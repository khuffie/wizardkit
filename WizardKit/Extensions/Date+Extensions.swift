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
