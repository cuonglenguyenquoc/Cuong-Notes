//
//  RegisterUserUseCase.swift
//  Cuong_Notes
//
//  Created by Macbook on 04/01/2024.
//

import Foundation
import Combine

protocol RegisterUserUseCase {
    func execute(requestValue: String) -> Future<UserModel, Error>
}

class DefaultRegisterUserUseCase: RegisterUserUseCase {
    
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute(requestValue: String) -> Future<UserModel, Error> {
        return userRepository.registerNewUser(with: requestValue)
    }
}
