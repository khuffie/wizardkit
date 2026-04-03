//
//  TipJarSection.swift
//  WizardKit
//
//  Created by Ahmed El-Khuffash on 2026-04-02.
//

import SwiftUI

/// A SettingsSection wrapper around TipJarView for embedding in settings screens.
public struct TipJarSection: View {
    private let items: [TipJarItem]
    private let storeKit: WizardStoreKitHelper

    public init(items: [TipJarItem], storeKit: WizardStoreKitHelper) {
        self.items = items
        self.storeKit = storeKit
    }

    public var body: some View {
        SettingsSection(icon: "heart.fill", title: "Tip Jar", expanded: false) {
            TipJarView(items: items, storeKit: storeKit)
        }
    }
}
