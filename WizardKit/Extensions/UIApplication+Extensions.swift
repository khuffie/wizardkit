//
//  UIApplication+Extensions.swift
//  WizardKit
//
//  Created by Ahmed El-Khuffash on 2026-04-02.
//

import UIKit

extension UIApplication {
    public var currentScene: UIWindowScene? {
        connectedScenes
            .first { $0.activationState == .foregroundActive } as? UIWindowScene
    }
}
