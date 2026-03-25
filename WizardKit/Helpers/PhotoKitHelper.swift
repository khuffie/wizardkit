//
//  PhotoKitHelper.swift
//  WizardKit
//
//  Created by Ahmed El-Khuffash on 2026-03-22.
//

import UIKit
import Photos
import CoreImage
import AVFoundation

/// Handles non-destructive photo and video edits via the PhotoKit content editing API.
/// Each edit applies `PHAdjustmentData` so the Photos library can identify the change.
public final class PhotoKitHelper {

    public static let shared = PhotoKitHelper()
    private init() {}

    // MARK: - Format Identifiers

    private enum Format {
        static let identifier = "com.photowizard"
        static let version = "1.0"
    }

    // MARK: - Photo Rotation

    /// Rotates a photo asset 90° counter-clockwise and commits the edit to the Photos library.
    public func rotatePhoto(asset: PHAsset, input: PHContentEditingInput, completion: @escaping (Bool, Error?) -> Void) {
        guard let url = input.fullSizeImageURL,
              let image = UIImage(contentsOfFile: url.path) else {
            completion(false, nil)
            return
        }

        let rotated = image.rotated90CounterClockwise()
        commitImage(rotated, input: input, formatSuffix: "rotate", adjustmentDescription: "rotate90ccw", asset: asset, completion: completion)
    }

    // MARK: - Live Photo Rotation

    /// Rotates a live photo asset 90° counter-clockwise and commits the edit to the Photos library.
    public func rotateLivePhoto(asset: PHAsset, input: PHContentEditingInput, completion: @escaping (Bool, Error?) -> Void) {
        guard let editingContext = PHLivePhotoEditingContext(livePhotoEditingInput: input) else {
            completion(false, nil)
            return
        }

        editingContext.frameProcessor = { frame, _ in
            return frame.image.oriented(.left)
        }

        let output = PHContentEditingOutput(contentEditingInput: input)
        output.adjustmentData = PHAdjustmentData(
            formatIdentifier: "\(Format.identifier).rotate",
            formatVersion: Format.version,
            data: "rotate90ccw".data(using: .utf8)!
        )

        editingContext.saveLivePhoto(to: output) { success, error in
            guard success else {
                DispatchQueue.main.async { completion(false, error) }
                return
            }
            PHPhotoLibrary.shared().performChanges {
                let request = PHAssetChangeRequest(for: asset)
                request.contentEditingOutput = output
            } completionHandler: { success, error in
                DispatchQueue.main.async { completion(success, error) }
            }
        }
    }

    // MARK: - Auto Enhance

    /// Applies CIImage auto-adjustment filters and commits the edit to the Photos library.
    public func autoEnhance(asset: PHAsset, input: PHContentEditingInput, completion: @escaping (Bool, Error?) -> Void) {
        guard let url = input.fullSizeImageURL,
              let ciImage = CIImage(contentsOf: url) else {
            completion(false, nil)
            return
        }

        let filters = ciImage.autoAdjustmentFilters()
        var enhanced = ciImage
        for filter in filters {
            filter.setValue(enhanced, forKey: kCIInputImageKey)
            if let output = filter.outputImage {
                enhanced = output
            }
        }

        let context = CIContext()
        guard let cgImage = context.createCGImage(enhanced, from: enhanced.extent) else {
            completion(false, nil)
            return
        }

        let result = UIImage(cgImage: cgImage)
        commitImage(result, input: input, formatSuffix: "enhance", adjustmentDescription: "autoenhance", asset: asset, completion: completion)
    }

    // MARK: - Video Rotation

    /// Rotates a video asset 90° clockwise and commits the edit to the Photos library.
    public func rotateVideo(asset: PHAsset, input: PHContentEditingInput, completion: @escaping (Bool, Error?) -> Void) {
        guard let avAsset = input.audiovisualAsset else {
            completion(false, nil)
            return
        }

        Task {
            guard let videoTrack = try? await avAsset.loadTracks(withMediaType: .video).first,
                  let duration = try? await avAsset.load(.duration) else {
                await MainActor.run { completion(false, nil) }
                return
            }

            let composition = AVMutableComposition()
            guard let compositionVideoTrack = composition.addMutableTrack(
                withMediaType: .video,
                preferredTrackID: kCMPersistentTrackID_Invalid
            ) else {
                await MainActor.run { completion(false, nil) }
                return
            }

            do {
                try compositionVideoTrack.insertTimeRange(
                    CMTimeRange(start: .zero, duration: duration),
                    of: videoTrack,
                    at: .zero
                )
            } catch {
                await MainActor.run { completion(false, error) }
                return
            }

            // Add audio track if present
            if let audioTrack = try? await avAsset.loadTracks(withMediaType: .audio).first,
               let compositionAudioTrack = composition.addMutableTrack(
                   withMediaType: .audio,
                   preferredTrackID: kCMPersistentTrackID_Invalid
               ) {
                try? compositionAudioTrack.insertTimeRange(
                    CMTimeRange(start: .zero, duration: duration),
                    of: audioTrack,
                    at: .zero
                )
            }

            // Apply 90° clockwise rotation
            guard let naturalSize = try? await videoTrack.load(.naturalSize),
                  let existingTransform = try? await videoTrack.load(.preferredTransform) else {
                await MainActor.run { completion(false, nil) }
                return
            }
            let rotation = CGAffineTransform(rotationAngle: .pi / 2)
            let translation = CGAffineTransform(translationX: naturalSize.height, y: 0)
            compositionVideoTrack.preferredTransform = existingTransform
                .concatenating(rotation)
                .concatenating(translation)

            // Export
            let output = PHContentEditingOutput(contentEditingInput: input)
            output.adjustmentData = PHAdjustmentData(
                formatIdentifier: "\(Format.identifier).rotate",
                formatVersion: Format.version,
                data: "rotate90cw".data(using: .utf8)!
            )

            guard let exportSession = AVAssetExportSession(
                asset: composition,
                presetName: AVAssetExportPresetHighestQuality
            ) else {
                await MainActor.run { completion(false, nil) }
                return
            }
            exportSession.outputURL = output.renderedContentURL
            exportSession.outputFileType = .mov

            await exportSession.export()
            guard exportSession.status == .completed else {
                await MainActor.run { completion(false, exportSession.error) }
                return
            }

            PHPhotoLibrary.shared().performChanges {
                let request = PHAssetChangeRequest(for: asset)
                request.contentEditingOutput = output
            } completionHandler: { success, error in
                DispatchQueue.main.async {
                    completion(success, error)
                }
            }
        }
    }

    // MARK: - Content Editing Input Request

    /// Convenience to request a content editing input for an asset.
    public func requestContentEditingInput(for asset: PHAsset, completion: @escaping (PHContentEditingInput?) -> Void) {
        let options = PHContentEditingInputRequestOptions()
        options.isNetworkAccessAllowed = true
        asset.requestContentEditingInput(with: options) { input, _ in
            completion(input)
        }
    }

    // MARK: - Private

    /// Writes a UIImage as JPEG at maximum quality to the output URL
    /// and commits the change to the Photos library.
    private func commitImage(
        _ image: UIImage,
        input: PHContentEditingInput,
        formatSuffix: String,
        adjustmentDescription: String,
        asset: PHAsset,
        completion: @escaping (Bool, Error?) -> Void
    ) {
        let output = PHContentEditingOutput(contentEditingInput: input)
        output.adjustmentData = PHAdjustmentData(
            formatIdentifier: "\(Format.identifier).\(formatSuffix)",
            formatVersion: Format.version,
            data: adjustmentDescription.data(using: .utf8)!
        )

        guard let jpegData = image.jpegData(compressionQuality: 1.0) else {
            completion(false, nil)
            return
        }

        do {
            try jpegData.write(to: output.renderedContentURL)
        } catch {
            completion(false, error)
            return
        }

        PHPhotoLibrary.shared().performChanges {
            let request = PHAssetChangeRequest(for: asset)
            request.contentEditingOutput = output
        } completionHandler: { success, error in
            DispatchQueue.main.async {
                completion(success, error)
            }
        }
    }
}

// MARK: - UIImage Helpers

public extension UIImage {
    /// Returns a new image rotated 90° counter-clockwise.
    func rotated90CounterClockwise() -> UIImage {
        let newSize = CGSize(width: size.height, height: size.width)
        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return self }
        context.translateBy(x: 0, y: newSize.height)
        context.rotate(by: -.pi / 2)
        draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext() ?? self
    }

}
