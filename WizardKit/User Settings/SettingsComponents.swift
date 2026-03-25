//
//  SettingsComponents.swift
//  WizardKit
//
//  Created by Ahmed El-Khuffash on 2026-03-21.
//

import SwiftUI

/// A custom DisclosureGroup style that tints the chevron with the accent color.
public struct AccentChevronDisclosureStyle: DisclosureGroupStyle {
    public init() {}
    public func makeBody(configuration: Configuration) -> some View {
        Button {
            withAnimation {
                configuration.isExpanded.toggle()
            }
        } label: {
            HStack {
                configuration.label
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(Theme.accentColor)
                    .rotationEffect(.degrees(configuration.isExpanded ? 90 : 0))
                    .animation(.easeInOut(duration: 0.2), value: configuration.isExpanded)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)

        if configuration.isExpanded {
            configuration.content
        }
    }
}

/// A disclosure-group section for settings screens.
/// Displays an icon + title label that expands to reveal content.
public struct SettingsSection<Content: View>: View {
    let icon: String
    let title: String
    @ViewBuilder let content: Content
    @State private var isExpanded: Bool

    public init(icon: String, title: String, expanded: Bool = true, @ViewBuilder content: () -> Content) {
        self.icon = icon
        self.title = title
        self._isExpanded = State(initialValue: expanded)
        self.content = content()
    }

    public var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            VStack(spacing: 0) {
                content
            }
            .padding(.top, 4)
        } label: {
            Label(title, systemImage: icon)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.tint)
        }
        .disclosureGroupStyle(AccentChevronDisclosureStyle())
        .tint(Theme.accentColor)
        .padding([.leading, .trailing])
        .padding(.top, 12)
        .padding(.bottom, 16)
    }
}

/// A toggle row for settings screens with an optional description.
public struct SettingsToggleRow: View {
    let title: String
    var description: String?
    @Binding var isOn: Bool

    public init(title: String, description: String? = nil, isOn: Binding<Bool>) {
        self.title = title
        self.description = description
        self._isOn = isOn
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Toggle(title, isOn: $isOn)
                .font(.subheadline)
            if let description {
                Text(description)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

/// A menu-picker row for settings screens.
public struct SettingsMenuRow<T: Hashable & CaseIterable, Label: View>: View where T.AllCases: RandomAccessCollection {
    let title: String
    @Binding var selection: T
    @ViewBuilder let label: (T) -> Label

    public init(title: String, selection: Binding<T>, @ViewBuilder label: @escaping (T) -> Label) {
        self.title = title
        self._selection = selection
        self.label = label
    }

    public var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
            Spacer()
            Picker(title, selection: $selection) {
                ForEach(T.allCases, id: \.self) { value in
                    label(value)
                }
            }
            .pickerStyle(.menu)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}
