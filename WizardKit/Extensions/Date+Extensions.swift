//
//  Date+Extensions.swift
//  tdotwiz
//
//  Created by Ahmed El-Khuffash on 2020-05-26.
//  Copyright © 2020 Ahmed El-Khuffash. All rights reserved.
//

import Foundation


//from https://stackoverflow.com/questions/43663622/is-a-date-in-same-week-month-year-of-another-date-in-swift
extension Date {

	public func isEqual(to date: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> Bool {
		calendar.isDate(self, equalTo: date, toGranularity: component)
	}

	public func isInSameYear(as date: Date) -> Bool { isEqual(to: date, toGranularity: .year) }
	public func isInSameMonth(as date: Date) -> Bool { isEqual(to: date, toGranularity: .month) }
	public func isInSameWeek(as date: Date) -> Bool { isEqual(to: date, toGranularity: .weekOfYear) }

	public func isInSameDay(as date: Date) -> Bool { Calendar.current.isDate(self, inSameDayAs: date) }

	public var isInThisYear:  Bool { isInSameYear(as: Date()) }
	public var isInThisMonth: Bool { isInSameMonth(as: Date()) }
	public var isInThisWeek:  Bool { isInSameWeek(as: Date()) }

	public var isInYesterday: Bool { Calendar.current.isDateInYesterday(self) }
	public var isInToday:     Bool { Calendar.current.isDateInToday(self) }
	public var isInTomorrow:  Bool { Calendar.current.isDateInTomorrow(self) }

	public var isInTheFuture: Bool {
		self.endOfDay > Date().endOfDay
	}
	public var isInThePast:   Bool {
		self.startOfDay < Date().startOfDay
	}
}

extension Date {
	public var startOfDay: Date {
		return Calendar.current.startOfDay(for: self)
	}

	public var endOfDay: Date {
		var components = DateComponents()
		components.day = 1
		components.second = -1
		return Calendar.current.date(byAdding: components, to: startOfDay)!
	}

	public var startOfMonth: Date {
		let components = Calendar.current.dateComponents([.year, .month], from: startOfDay)
		return Calendar.current.date(from: components)!
	}

	public var endOfMonth: Date {
		var components = DateComponents()
		components.month = 1
		components.second = -1
		return Calendar.current.date(byAdding: components, to: startOfMonth)!
	}
}
