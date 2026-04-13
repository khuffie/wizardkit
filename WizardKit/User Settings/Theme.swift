//
//  Theme.swift
//  WizardKit
//
//  Created by Ahmed El-Khuffash on 2020-09-11.
//

import Foundation
import SwiftUI

/// Provides the user-selected accent color from a stored hex string.
/// Primary, secondary, and background colors use native SwiftUI semantics.
public enum Theme {

    public static let defaultAccentHex = "FB4D00"

    /// Each app sets this closure at launch to provide the stored accent hex.
    /// Defaults to returning `defaultAccentHex` until configured.
    public static var accentHexProvider: () -> String = { defaultAccentHex }

    /// Returns the user's accent color built from the stored hex.
    public static var accentColor: Color {
        let hex = accentHexProvider()
        if let uiColor = UIColor(hex: hex) {
            return Color(uiColor)
        }
        return Color(UIColor(hex: defaultAccentHex)!)
    }

    // MARK: - Swatches

    public struct Swatch: Identifiable, Hashable {
        public let id: String
        public let name: String
        public let hex: String

        public var color: Color {
            Color(UIColor(hex: hex)!)
        }
    }

    public static let swatches: [Swatch] = [
        // Reds
        Swatch(id: "crimson",  name: "Crimson",       hex: "E63946"),
        Swatch(id: "coral",    name: "Coral",         hex: "FF6B6B"),
        // Oranges
        Swatch(id: "blaze",    name: "Blaze Orange",  hex: "FB4D00"),
        Swatch(id: "amber",    name: "Amber",         hex: "F77F00"),
        // Yellows
        Swatch(id: "golden",   name: "Golden",        hex: "FFAB00"),
        Swatch(id: "sunflower",name: "Sunflower",     hex: "FFD600"),
        // Greens
        Swatch(id: "forest",   name: "Forest",        hex: "2D6A4F"),
        Swatch(id: "emerald",  name: "Emerald",       hex: "2DC653"),
        Swatch(id: "mint",     name: "Mint",          hex: "52B788"),
        // Blues
        Swatch(id: "ocean",    name: "Ocean Blue",    hex: "0096C7"),
        Swatch(id: "cyan",     name: "Cyan",          hex: "00B4D8"),
        Swatch(id: "indigo",   name: "Indigo",        hex: "6C63FF"),
        // Purples / Pinks
        Swatch(id: "violet",   name: "Violet",        hex: "7B2FBE"),
        Swatch(id: "magenta",  name: "Magenta",       hex: "E040FB"),
    ]
}

// MARK: - UIColor Hex Support
extension UIColor {

    public convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        let length = hexSanitized.count

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
        } else {
            return nil
        }

        self.init(red: r, green: g, blue: b, alpha: a)
    }

    /// Returns the receiver's color as a 6-character uppercase hex string (e.g. "FF6B6B").
    public var hexString: String {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return String(format: "%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
    }
}
