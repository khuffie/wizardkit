//
//  Date+Extensions.swift
//  tdotwiz
//
//  Created by Ahmed El-Khuffash on 2020-05-26.
//  Copyright © 2020 Ahmed El-Khuffash. All rights reserved.
//

import Foundation
import SWXMLHash


//supporting XML deserialization of date. Right now only limited to one date format...
extension Date: XMLElementDeserializable, XMLAttributeDeserializable {
     public static func deserialize(_ element: XMLElement) throws -> Date {
        let date = stringToDate(element.text)

        guard let validDate = date else {
            throw XMLDeserializationError.typeConversionFailed(type: "Date", element: element)
        }

        return validDate
    }

    public static func deserialize(_ attribute: XMLAttribute) throws -> Date {
        let date = stringToDate(attribute.text)

        guard let validDate = date else {
            throw XMLDeserializationError.attributeDeserializationFailed(type: "Date", attribute: attribute)
        }

        return validDate
    }

    public static func stringToDate(_ dateAsString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y-MM-dd"
        return dateFormatter.date(from: dateAsString)
    }
}


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

	public var isInTheFuture: Bool { self > Date() }
	public var isInThePast:   Bool { self < Date() }
}
