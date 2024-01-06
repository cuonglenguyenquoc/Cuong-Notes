//
//  UserRepository.swift
//  Cuong_Notes
//
//  Created by Macbook on 03/01/2024.
//

import Foundation
import Combine

protocol UserRepository {
    func getUserInfo() -> Future<UserModel?, Error>
    func registerNewUser(with username: String) -> Future<UserModel, Error>
}
