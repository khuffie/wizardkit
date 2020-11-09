//
//  ImagePicker.swift
//  WizardKit
//
//  Created by Ahmed El-Khuffash on 2020-10-07.
//  Copyright © 2020 Ahmed El-Khuffash. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

public struct ImagePicker: UIViewControllerRepresentable {
	
	@Environment(\.presentationMode) public var presentationMode
	@Binding public var image: UIImage?
	
	public init(image: Binding<UIImage?>) {
		self._image = image
	}
	
	public func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
		let picker = UIImagePickerController()
		picker.delegate = context.coordinator
		return picker
	}
	
	public func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
		
	}
	
	public func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
	
	
	public class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
		let parent: ImagePicker
		
		public init(_ parent: ImagePicker) {
			self.parent = parent
		}
		
		public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
			if let uiImage = info[.originalImage] as? UIImage {
				parent.image = uiImage
			}
			
//			if let imageUrl = info[.imageURL] as? URL {
//				parent.imageUrl = imageUrl
//				print(imageUrl)
//			}
			
			parent.presentationMode.wrappedValue.dismiss()
		}
	}
}
