//
//  UserSettings.swift
//  WizardKit
//
//  Created by Ahmed El-Khuffash on 2025-10-19.
//  Copyright © 2025 Ahmed El-Khuffash. All rights reserved.
//

import SwiftyUserDefaults

extension DefaultsKeys {
    
    // MARK: GENERAL SETTINGS
   public var firstLaunch: DefaultsKey<Bool> { .init("First Launch", defaultValue: true) }

    
    // MARK: UI SETTINGS
    public var darkTheme: DefaultsKey<[String : String ]> { .init("Dark Theme", defaultValue: Theme.defaultDark ) }
    public var lightTheme: DefaultsKey<[String : String ]> { .init("Light Theme", defaultValue: Theme.defaultLight ) }
}

public class UserSettings: NSObject,  ObservableObject {
    //public static let shared = UserSettings()
    public static var shared = DefaultsAdapter<DefaultsKeys>(defaults: UserDefaults(suiteName: "group.com.khuffie.widget.wizard")!, keyStore: .init())
}
