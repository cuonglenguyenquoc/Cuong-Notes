//
//  MockUserRepository.swift
//  Cuong_NotesTests
//
//  Created by Macbook on 07/01/2024.
//

import Foundation
import Combine
@testable import Cuong_Notes

class MockSuccessUserRepository: UserRepository {
    
    private(set) var invokedGetUserInfo: Bool = false
    private(set) var invokedRegisterNewUser: Bool = false
    
    func getUserInfo() -> Future<Cuong_Notes.UserModel?, Error> {
        invokedGetUserInfo = true
        return Future<Cuong_Notes.UserModel?, Error> { promise in
            promise(.success(nil))
        }
    }
    
    func registerNewUser(with username: String) -> Future<Cuong_Notes.UserModel, Error> {
        invokedRegisterNewUser = true
        return Future<Cuong_Notes.UserModel, Error> { promise in
            promise(.success(UserModel(id: "123", userName: username)))
        }
    }
}
