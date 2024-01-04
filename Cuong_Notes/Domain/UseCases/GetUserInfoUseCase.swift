//
//  GetUserInfoUseCase.swift
//  Cuong_Notes
//
//  Created by Macbook on 03/01/2024.
//

import Foundation
import Combine

protocol GetUserInfoUseCase {
    func execute(requestValue: String) -> Future<UserModel?, Error>
}

class DefaultGetUserInfoUseCase: GetUserInfoUseCase {
    
    private let userReposity: UserReposity
    
    init(userReposity: UserReposity) {
        self.userReposity = userReposity
    }
    
    func execute(requestValue: String) -> Future<UserModel?, Error> {
        return userReposity.getUserInfo(with: requestValue)
    }
}
