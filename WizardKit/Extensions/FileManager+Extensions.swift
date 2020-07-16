//
//  FileManager+Extensions.swift
//  tdotwiz
//
//  Created by Ahmed El-Khuffash on 2020-05-25.
//  Copyright © 2020 Ahmed El-Khuffash. All rights reserved.
//

import Foundation

public extension FileManager {
	
	//from https://www.hackingwithswift.com/books/ios-swiftui/writing-data-to-the-documents-directory 
	static func getDocumentsDirectory() -> URL {
		// find all possible documents directories for this user
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

		// just send back the first one, which ought to be the only one
		return paths[0]
	}
	
	static func fileModificationDate(url: URL) -> Date? {
		do {
			let attr = try FileManager.default.attributesOfItem(atPath: url.path)
			return attr[FileAttributeKey.modificationDate] as? Date
		} catch {
			return nil
		}
	}
}


