//
//  UIImage+Extensions.swift
//  WizardKit
//
//  Created by Ahmed El-Khuffash on 2020-11-11.
//  Copyright © 2020 Ahmed El-Khuffash. All rights reserved.
//

import Foundation

import UIKit

extension UIImage {

    public func scale(toSize newSize:CGSize) -> UIImage {

        // make sure the new size has the correct aspect ratio
        let aspectFill = self.size.resizeFill(toSize: newSize)

        UIGraphicsBeginImageContextWithOptions(aspectFill, false, 0.0);
        self.draw(in: CGRect(x: 0, y: 0, width: aspectFill.width, height: aspectFill.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return newImage
    }

}
