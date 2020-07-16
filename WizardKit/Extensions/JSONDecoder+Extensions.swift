//
//  JSONDecoder+Extensions.swift
//  tdotwiz
//
//  Created by Ahmed El-Khuffash on 2020-05-29.
//  Copyright © 2020 Ahmed El-Khuffash. All rights reserved.
//

import Foundation



public extension JSONDecoder {

	/**
	Allows the decoding of a JSON object by a specific keypath rather than the full path
	Taken from: https://gist.github.com/sgr-ksmt/d3b79ed1504768f2058c5ea06dc93698
	*/
	func decode<T: Decodable>(_ type: T.Type, from data: Data, keyPath: String) throws -> T {
        let toplevel = try JSONSerialization.jsonObject(with: data)
        if let nestedJson = (toplevel as AnyObject).value(forKeyPath: keyPath) {
            let nestedJsonData = try JSONSerialization.data(withJSONObject: nestedJson)
            return try decode(type, from: nestedJsonData)
        } else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Nested json not found for key path \"\(keyPath)\""))
        }
    }
}
