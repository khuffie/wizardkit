//
//  TipJarView.swift
//  WizardKit
//
//  Created by Ahmed El-Khuffash on 2026-04-02.
//

import SwiftUI
import StoreKit

/// Configuration for a single tip item.
public struct TipJarItem: Identifiable {
    public let id: String          // product identifier
    public let title: String       // e.g. "Buy me a coffee."
    public let systemImage: String? // SF Symbol name
    public let image: String?       // Asset catalog image name

    public init(id: String, title: String, systemImage: String) {
        self.id = id
        self.title = title
        self.systemImage = systemImage
        self.image = nil
    }

    public init(id: String, title: String, image: String) {
        self.id = id
        self.title = title
        self.systemImage = nil
        self.image = image
    }
}

/// A generic tip jar view that shows a list of tip products with purchase buttons.
public struct TipJarView: View {
    private let items: [TipJarItem]
    private let storeKit: WizardStoreKitHelper
    private let subtitle: String

    public init(
        items: [TipJarItem],
        storeKit: WizardStoreKitHelper,
        subtitle: String = "Help support continued app development and new features."
    ) {
        self.items = items
        self.storeKit = storeKit
        self.subtitle = subtitle
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(subtitle)
                .fixedSize(horizontal: false, vertical: true)
                .font(.callout)
                .foregroundStyle(.secondary)

            ForEach(items) { item in
                if let product = storeKit.product(for: item.id) {
                    HStack {
                        if let systemImage = item.systemImage {
                            Image(systemName: systemImage)
                                .foregroundStyle(.tint)
                                .frame(width: 28, height: 28)
                        } else if let image = item.image {
                            Image(image)
                                .resizable()
                                .renderingMode(.template)
                                .foregroundStyle(.tint)
                                .frame(width: 28, height: 28)
                        }

                        Text(item.title)

                        Spacer()

                        Button {
                            Task { try? await storeKit.purchase(product) }
                        } label: {
                            Text(product.displayPrice)
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(.white)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 8)
                                .background(.tint, in: Capsule())
                        }
                    }
                }
            }

            if storeKit.purchaseSuccess {
                Text("Thank you for your support!")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 4)
            }
        }
        .padding()
    }
}
