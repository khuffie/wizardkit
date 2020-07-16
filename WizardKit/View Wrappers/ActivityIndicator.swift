//
//  ActivityIndicator.swift
//  WizardKit
//
//  Created by Ahmed El-Khuffash on 2020-06-25.
//  Copyright © 2020 Ahmed El-Khuffash. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit


public struct ActivityIndicator: UIViewRepresentable {
    //@Binding public var shouldAnimate: Bool
	
	public init() {
		//shouldAnimate: Binding<Bool>
		//self._shouldAnimate = shouldAnimate
	}

    
    public func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView()
    }

    public func updateUIView(_ uiView: UIActivityIndicatorView,
                      context: Context) {
		
		uiView.startAnimating()
//        if self.shouldAnimate {
//            uiView.startAnimating()
//        } else {
//            uiView.stopAnimating()
//        }
    }
}
