//
//  Encodable+Ext.swift
//  Cuong_Notes
//
//  Created by Macbook on 03/01/2024.
//

import Foundation

extension Encodable {
    
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data,
                                                  options: .allowFragments))
            .flatMap { $0 as? [String: Any] }
    }
    
    var array: [Any]? {
        let jsonData = try? JSONEncoder().encode(self)
        return try? JSONSerialization.jsonObject(with: jsonData ?? Data.init(), options: .allowFragments) as? [Any]
    }
}
