//
//  NSArray+Ext.swift
//  Cuong_Notes
//
//  Created by Macbook on 03/01/2024.
//

import Foundation

extension NSArray {
    
    func decode<T>(_ type: T.Type) -> T? where T: Decodable {
        let jsonData = (try? JSONSerialization.data(withJSONObject: self, options: [])) ?? Data.init()
        return try? JSONDecoder().decode(type, from: jsonData)
    }

    func encode<T>(_ value: T) -> Any? where T: Encodable {
        let jsonData = try? JSONEncoder().encode(value)
        return try? JSONSerialization.jsonObject(with: jsonData ?? Data.init(), options: .allowFragments)
    }
}
