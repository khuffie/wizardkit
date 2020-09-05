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
	
	public let simpleShort: DateFormatter = {
	   let formatter = DateFormatter()
		formatter.dateFormat = "EEE',' MMM d"
	   return formatter
	}()
	

	public let short: DateFormatter = {
	   let formatter = DateFormatter()
		formatter.dateStyle = .short
	   return formatter
	}()
	
	public let fullDay: DateFormatter = {
		let formatter = DateFormatter()
		formatter.timeZone = .current
		formatter.dateFormat = "EEEE"
		return formatter
	}()
	
	public let dayAndDate: DateFormatter = {
		let formatter = DateFormatter()
		formatter.timeZone = .current
		formatter.dateFormat = "EEEE, d"
		return formatter
	}()


	public let shortDay: DateFormatter = {
		let formatter = DateFormatter()
		formatter.timeZone = .current
		formatter.dateFormat = "EEE"
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
		//formatter.timeZone = .current
		formatter.timeStyle = .short
		//formatter.setLocalizedDateFormatFromTemplate("HH:mm a")
	//	formatter.dateFormat = "h:mm a"
		return formatter
	}()
	public let hourMinutesNoAMPM: DateFormatter = {
		let formatter = DateFormatter()
		formatter.timeZone = .current
		formatter.timeStyle = .short
		//formatter.setLocalizedDateFormatFromTemplate("HH:mm")
		//formatter.dateFormat = "h:mm"
		return formatter
	}()

	public let month: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "MMMM"
		return formatter
	}()
	

	public func friendlyDateDisplay(for date: Date, isShort: Bool = false) -> String {
		
		if Calendar.current.isDateInToday(date) {
			return "Today"
		} else if Calendar.current.isDateInTomorrow(date) {
			return "Tomorrow"
		} else if isShort {
			return simpleShort.string(from: date )
		} else {
			return simple.string(from: date )
		}
		
		
	}
	

	public func timeNoAMPM(from date:Date) -> String {
		var string = DateHelper.shared.hourMinutes.string(from: date )
		string = string.replacingOccurrences(of: " AM", with: "")
		string = string.replacingOccurrences(of: " PM", with: "")
		
		return string
	}

	
	public func today() -> Date {
		Calendar.current.startOfDay(for: Date())
	}
	
	public func tomorrow() -> Date {
		
		// Create the end date components.
		var tomorrowComponents = DateComponents()
		tomorrowComponents.day = 1
		tomorrowComponents.hour = 23
		tomorrowComponents.minute = 59
		tomorrowComponents.second = 59
		let tomorrowDate:Date = Calendar.current.date(byAdding: tomorrowComponents, to: Date())!

		return tomorrowDate
	}
	
	public func nextWidgetRefreshDate(frequency:Int = 15) -> Date {
		let frequency:Int = frequency
		let interval:TimeInterval = 60 * Double(frequency)
		let original = Date()
		let refreshDate = Date(timeIntervalSinceReferenceDate:
								(original.timeIntervalSinceReferenceDate / interval).rounded(.up) * interval)

		return refreshDate
	}
	
	public func getDaysUntil(from date:Date, to:Date) -> Int {
		
		let components = Calendar.current.dateComponents([.day], from: date, to: to)
		
		return components.day!
	}
	
	public func getHoursUntil(from date:Date, to:Date) -> Int {
		
		let components = Calendar.current.dateComponents([.day, .hour], from: date, to: to)
		
		return components.hour!
	}

	
	public func getWeekdaySymbols(for firstDayOfWeek:Int, type: String = "short") -> [String] {
		//print("WizardKit.getWeekdaySymbols \(firstDayOfWeek)")
		var symbols:[String]
		
		switch type {
		default:
			symbols = Calendar.current.veryShortStandaloneWeekdaySymbols
		}
		
//		if firstDayOfWeek == 1 {
//			return symbols
//		}
		
		var sortedSymbols:[String] = []
		var index = firstDayOfWeek - 1
		
		//the first one
		while sortedSymbols.count < symbols.count {
			sortedSymbols.append(symbols[index])
			
			index += 1
			if index == symbols.count {
				index = 0
			}
		}
		
		
		
		return sortedSymbols
		
	}
	
	
	
	override private init() {
		super.init()
	}
	
}

