//
//  String+Extensions.swift
//  tdotwiz
//
//  Created by Ahmed El-Khuffash on 2020-05-21.
//  Copyright © 2020 Ahmed El-Khuffash. All rights reserved.
//

import Foundation
public extension String {
	
	//decode HTML from encoded JSOn response
	func htmlDecoded()->String {
        
        guard (self != "") else { return self }
        
        var newStr = self
        // from https://en.wikipedia.org/wiki/List_of_XML_and_HTML_character_entity_references
        let entities = [ //a dictionary of HTM/XML entities.
            "&quot;"    : "\"",
            "&amp;"     : "&",
            "&apos;"    : "'",
            "&lt;"      : "<",
            "&gt;"      : ">",
            "&deg;"     : "º",
			"&#x27;"	: "'"
            ]
        
        for (name,value) in entities {
            newStr = newStr.replacingOccurrences(of: name, with: value)
        }
        return newStr
    }

}
