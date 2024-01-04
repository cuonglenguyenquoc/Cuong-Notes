//
//  FirebaseDatabaseManager.swift
//  Cuong_Notes
//
//  Created by Macbook on 03/01/2024.
//

import Foundation
import Firebase
import FirebaseDatabase

enum FirebaseError: Error {
    case encodingError
    case decodingError
}

// TODO: - Add query support

class FirebaseDatabaseManager {
    
    // MARK: - Singleton Instance
    static let shared = FirebaseDatabaseManager()
    
    // MARK: - Instance Variables
    private lazy var databaseReference: DatabaseReference = Database.database().reference()

    // MARK: - Init
    private init() {
        
    }
    
    // MARK: - Configuration
    func configure() {
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true
    }
    
    // MARK: - CRUD Operations
    func readOnce<T: Codable>(from endpoint: FirebaseDatabaseEndpoint,
                              completion: ((Result<T, Error>) -> Void)? = nil) {
        let query = databaseReference.child(endpoint.path)
        query.keepSynced(endpoint.synced)
        
        query.observeSingleEvent(of: .value,
                                 with: { snapshot in
            var decodedValue: T?
            if let value = snapshot.value as? NSDictionary {
                decodedValue = value.decodeAsArray(T.self)
                if decodedValue == nil {
                    decodedValue = value.decode(T.self)
                }
            }
            if let value = snapshot.value as? NSArray {
                decodedValue = value.decode(T.self)
            }
            if let decodedValue = decodedValue {
                completion?(.success(decodedValue))
            } else {
                completion?(.failure(FirebaseError.decodingError))
            }
        }) { error in
            completion?(.failure(error))
        }
    }
    
    func post<T: Codable>(from endpoint: FirebaseDatabaseEndpoint,
                          data: T,
                          createNewKey: Bool = false,
                          completion: ((Result<T, Error>) -> Void)? = nil) {
        var encodedData: Any?
        if let value = data.dictionary {
            encodedData = value
        }
        if let value = data.array {
            encodedData = value
        }
        if encodedData == nil {
            completion?(.failure(FirebaseError.encodingError))
            return
        }
        var reference: DatabaseReference = databaseReference.child(endpoint.path)
        if createNewKey { reference = reference.childByAutoId() }
        reference.setValue(encodedData) { (error, _) in
            if let error = error { completion?(.failure(error)) }
            completion?(.success(data))
        }
    }
    
    func remove(from endpoint: FirebaseDatabaseEndpoint,
                completion: ((Result<Void, Error>) -> Void)? = nil) {
        databaseReference.child(endpoint.path).removeValue { (error, reference) in
            if let error = error {
                completion?(.failure(error))
                return
            }
            completion?(.success(()))
        }
    }
    
}
