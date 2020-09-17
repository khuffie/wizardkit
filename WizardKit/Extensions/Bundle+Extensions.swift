//
//  Bundle+Extensions.swift
//  WizardKit
//
//  Created by Ahmed El-Khuffash on 2020-09-10.
//  Copyright © 2020 Ahmed El-Khuffash. All rights reserved.
//

import Foundation

extension Bundle {
	public var releaseVersionNumber: String? {
		return infoDictionary?["CFBundleShortVersionString"] as? String
	}
	public var buildVersionNumber: String? {
		return infoDictionary?["CFBundleVersion"] as? String
	}
}

