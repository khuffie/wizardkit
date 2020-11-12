//
//  CGSize+Extensions.swift
//  WizardKit
//
//  Created by Ahmed El-Khuffash on 2020-11-11.
//  Copyright © 2020 Ahmed El-Khuffash. All rights reserved.
//

import Foundation
import UIKit

extension CGSize {

    public func resizeFill(toSize: CGSize) -> CGSize {

        let scale : CGFloat = (self.height / self.width) < (toSize.height / toSize.width) ? (self.height / toSize.height) : (self.width / toSize.width)
        return CGSize(width: (self.width / scale), height: (self.height / scale))

    }
}
