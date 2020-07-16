//
//  EmptyModifier.swift
//  WizardKit
//
//  Created by Ahmed El-Khuffash on 2020-06-20.
//  Copyright © 2020 Ahmed El-Khuffash. All rights reserved.
// https://medium.com/@iosdev/conditional-views-in-swiftui-dc09c808bc30

import SwiftUI

struct EmptyModifier: ViewModifier {

    let isEmpty: Bool

    func body(content: Content) -> some View {
        Group {
            if isEmpty {
                EmptyView()
            } else {
                content
            }
        }
    }
}


extension View {
    /// Whether the view should be empty.
    /// - Parameter bool: Set to `true` to hide the view (return EmptyView instead). Set to `false` to show the view.
    public func isEmpty(_ bool: Bool) -> some View {
        modifier(EmptyModifier(isEmpty: bool))
    }
}
