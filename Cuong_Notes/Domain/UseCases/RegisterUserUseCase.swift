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
    
    private let userReposity: UserReposity
    
    init(userReposity: UserReposity) {
        self.userReposity = userReposity
    }
    
    func execute(requestValue: String) -> Future<UserModel, Error> {
        return userReposity.registerNewUser(with: requestValue)
    }
}
