//
//  WizardSettings.swift
//  WizardKit
//
//  Created by Ahmed El-Khuffash on 2026-03-21.
//

import Foundation
import SwiftUI
import Defaults

/// Base settings class for all Wizard apps.
/// Provides shared properties (`accentColorHex`, `firstLaunch`, `lastBuildNumber`)
/// backed by `Defaults` keys stored in the app's suite.
/// Automatically configures `Theme.accentHexProvider` on init.
@Observable
open class WizardSettings {

    // MARK: - Suite

    /// The `UserDefaults` suite for this app, set during init.
    @ObservationIgnored public let suite: UserDefaults

    // MARK: - Defaults Keys

    /// Keys for settings shared across all Wizard apps.
    /// Stored per-suite so each app has its own values.
    @ObservationIgnored private let accentColorHexKey: Defaults.Key<String>
    @ObservationIgnored private let firstLaunchKey: Defaults.Key<Bool>
    @ObservationIgnored private let lastBuildNumberKey: Defaults.Key<Int>

    // MARK: - Shared Properties

    /// The user's chosen accent color as a hex string.
    /// Uses manual observation tracking because the backing store is external (`Defaults`).
    open var accentColorHex: String {
        get {
            access(keyPath: \.accentColorHex)
            return Defaults[accentColorHexKey]
        }
        set {
            withMutation(keyPath: \.accentColorHex) {
                Defaults[accentColorHexKey] = newValue
            }
        }
    }

    /// Whether this is the first launch of the app.
    open var firstLaunch: Bool {
        get { Defaults[firstLaunchKey] }
        set { Defaults[firstLaunchKey] = newValue }
    }

    /// The last build number the app ran at, for migration logic.
    open var lastBuildNumber: Int {
        get { Defaults[lastBuildNumberKey] }
        set { Defaults[lastBuildNumberKey] = newValue }
    }

    // MARK: - Init

    @MainActor public init(suite: UserDefaults) {
        self.suite = suite
        self.accentColorHexKey = Defaults.Key<String>("AccentColorHex", default: Theme.defaultAccentHex, suite: suite)
        self.firstLaunchKey = Defaults.Key<Bool>("First Launch", default: true, suite: suite)
        self.lastBuildNumberKey = Defaults.Key<Int>("General-LastBuildNumber", default: 1, suite: suite)

        Theme.accentHexProvider = { [weak self] in
            self?.accentColorHex ?? Theme.defaultAccentHex
        }
    }
}
