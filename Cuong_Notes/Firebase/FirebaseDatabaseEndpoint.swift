//
//  FirebaseDatabaseEndpoint.swift
//  Cuong_Notes
//
//  Created by Macbook on 03/01/2024.
//

import Foundation

protocol FirebaseDatabaseEndpoint {
    var path: String { get }
    var synced: Bool { get }
    
}

extension FirebaseDatabaseEndpoint {
    
    func retrieve<T: Codable>(completion: ((Result<T, Error>) -> Void)? = nil) {
        FirebaseDatabaseManager.shared.readOnce(from: self,
                                                completion: completion)
    }
    
    func post<T: Codable>(data: T,
                          createNewKey: Bool = false,
                          completion: ((Result<T, Error>) -> Void)? = nil) {
        FirebaseDatabaseManager.shared.post(from: self,
                                            data: data,
                                            createNewKey: createNewKey,
                                            completion: completion)
    }
    
    func remove(completion: ((Result<Void, Error>) -> Void)? = nil) {
        FirebaseDatabaseManager.shared.remove(from: self, completion: completion)
    }
    
}
