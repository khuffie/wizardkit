//
//  URL+Extensions.swift
//  WizardKit
//
//  Created by Ahmed El-Khuffash on 2020-11-11.
//  Copyright © 2020 Ahmed El-Khuffash. All rights reserved.
//

import Foundation

public extension URL {

    /// Returns a URL for the given app group and database pointing to the sqlite database.
    static func storeURL(for appGroup: String, databaseName: String) -> URL {
        guard let fileContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) else {
            fatalError("Shared file container could not be created.")
        }

        return fileContainer.appendingPathComponent("\(databaseName).sqlite")
    }
}
