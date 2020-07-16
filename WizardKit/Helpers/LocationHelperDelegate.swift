//
//  LocationHelperProtocol.swift
//  tdotwiz
//
//  Created by Ahmed El-Khuffash on 2020-06-07.
//  Copyright © 2020 Ahmed El-Khuffash. All rights reserved.
//

import Foundation
import MapKit

@objc public protocol LocationHelperDelegate {

	func locationUpdated(location: CLLocation)
	@objc func setLocationHelperDelegate()
}
