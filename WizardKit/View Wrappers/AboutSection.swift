//
//  AboutSection.swift
//  WizardKit
//
//  Created by Ahmed El-Khuffash on 2026-03-22.
//

import SwiftUI

/// Identifies which app is currently running, so its icon can be hidden.
public enum WizardApp: String, CaseIterable {
    case photoWizard
    case widgetWizard
    case boardGameWizard
    case torontoWizard
}

/// Reusable About disclosure group for settings screens.
/// Displays subreddit link, builder credit, app icons, and icons8 attribution.
public struct AboutSection: View {
    private let currentApp: WizardApp
    private let bundle = Bundle(for: PhotoKitHelper.self)

    private struct AppLink {
        let app: WizardApp
        let icon: String
        let name: String
        let catName: String
        let url: String
        let hidden: Bool
    }

    private let appLinks: [AppLink] = [
        AppLink(app: .photoWizard, icon: "icon-photo", name: "Photo Wizard", catName: "Gandalf", url: "https://apps.apple.com/us/app/photo-wizard/id6760589963", hidden: false),
        AppLink(app: .widgetWizard, icon: "icon-widget", name: "Widget Wizard", catName: "Marvin", url: "https://apps.apple.com/ca/app/widget-wizard/id1524227906", hidden: false),
        AppLink(app: .boardGameWizard, icon: "icon-bg", name: "Board Game Wizard", catName: "Link", url: "https://apps.apple.com/ca/app/board-game-wizard/id6446234137", hidden: false),
        AppLink(app: .torontoWizard, icon: "icon-toronto", name: "Toronto Wizard", catName: "Raccoon", url: "https://apps.apple.com/us/app/toronto-wizard/id1515135610", hidden: true),
    ]

    private var visibleApps: [AppLink] {
        appLinks.filter { $0.app != currentApp && !$0.hidden }
    }

    public init(currentApp: WizardApp) {
        self.currentApp = currentApp
    }

    public var body: some View {
        SettingsSection(icon: "info.circle", title: "About") {
            // Reddit
            Link(destination: URL(string: "https://www.reddit.com/r/appwizard/")!) {
                row(icon: "reddit", title: "App Wizard Subreddit", showChevron: true)
            }

            // Built by
            row(icon: "app-symbol", title: "Built by Ahmed El-Khuffash", showChevron: false)

            // App icons — sized to fit in one row
            HStack(alignment: .top, spacing: 12) {
                ForEach(visibleApps, id: \.name) { appLink in
                    Link(destination: URL(string: appLink.url)!) {
                        VStack(spacing: 6) {
                            Image(appLink.icon, bundle: bundle)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 16))

                            VStack(spacing: 2) {
                                Text(appLink.name)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(2)
                                    .multilineTextAlignment(.center)

                                Text(appLink.catName)
                                    .font(.caption2)
                                    .foregroundStyle(.tertiary)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)

            // Icons8
            Link(destination: URL(string: "https://icons8.com/")!) {
                row(icon: "icons8", title: "Some icons by Icons8", showChevron: true)
            }
        }
    }

    private func row(icon: String, title: String, showChevron: Bool) -> some View {
        HStack(spacing: 10) {
            Image(icon, bundle: bundle)
                .resizable()
                .renderingMode(.template)
                .foregroundStyle(.tint)
                .frame(width: 22, height: 22)

            Text(title)
                .font(.subheadline)
                .foregroundStyle(.primary)

            Spacer()

            if showChevron {
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
}
