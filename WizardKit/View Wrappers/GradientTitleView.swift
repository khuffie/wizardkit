//
//  GradientTitleView.swift
//  WizardKit
//
//  Created by Ahmed El-Khuffash on 2026-03-25.
//

import SwiftUI

/// Floating large title with a dark-to-transparent gradient backdrop.
/// Use as an overlay on scrollable content for a bold tab-level heading.
public struct GradientTitleView: View {
    let title: String

    public init(title: String) {
        self.title = title
    }

    public var body: some View {
        VStack(spacing: 0) {
            LinearGradient(
                colors: [.black, .black.opacity(0.5), .clear],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 150)
            .ignoresSafeArea(.all, edges: .top)
            .allowsHitTesting(false)

            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.horizontal, 8)
                .offset(y: -50)
        }
    }
}
