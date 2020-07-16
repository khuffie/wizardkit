//
//  DateHelper.swift
//  tdotwiz
//
//  Created by Ahmed El-Khuffash on 2020-06-12.
//  Copyright © 2020 Ahmed El-Khuffash. All rights reserved.
//

import Foundation

public class DateHelper: NSObject,  ObservableObject {
	public static let shared = DateHelper()
	
	public let simple: DateFormatter = {
	   let formatter = DateFormatter()
		formatter.dateFormat = "EEEE',' MMMM d"
	   return formatter
	}()
	
	public let short: DateFormatter = {
	   let formatter = DateFormatter()
		formatter.dateStyle = .short
	   return formatter
	}()

	
	public let hour: DateFormatter = {
		let formatter = DateFormatter()
		formatter.timeZone = .current
		formatter.dateFormat = "h a"
		return formatter
	}()

	public let hourMinutes: DateFormatter = {
		let formatter = DateFormatter()
		formatter.timeZone = .current
		formatter.dateFormat = "h:mm a"
		return formatter
	}()

	
	override private init() {
		super.init()
	}
	
}

