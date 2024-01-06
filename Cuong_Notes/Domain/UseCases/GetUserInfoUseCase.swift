//
//  GetUserInfoUseCase.swift
//  Cuong_Notes
//
//  Created by Macbook on 03/01/2024.
//

import Foundation
import Combine

protocol GetUserInfoUseCase {
    func execute() -> Future<UserModel?, Error>
}

class DefaultGetUserInfoUseCase: GetUserInfoUseCase {
    
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute() -> Future<UserModel?, Error> {
        return userRepository.getUserInfo()
    }
}