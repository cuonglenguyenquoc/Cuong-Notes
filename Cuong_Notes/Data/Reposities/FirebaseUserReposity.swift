//
//  FirebaseUserReposity.swift
//  Cuong_Notes
//
//  Created by Macbook on 04/01/2024.
//

import Foundation
import Combine

class FirebaseUserReposity: UserReposity {
    
    func getUserInfo(with id: String) -> Future<UserModel?, Error> {
        Future<UserModel?, Error> { promise in
            UserFirebaseEndpoint
                .getCurrentUserInfo
                .retrieve { (result: Result<UserModel, Error>) in
                    switch result {
                    case .success(let userInfo):
                        promise(.success(userInfo))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
        }
    }
    
    func registerNewUser(with username: String) -> Future<UserModel, Error> {
        Future<UserModel, Error> { promise in
            let userModel = UserModel(id: UserFirebaseEndpoint.userId, userName: username)
            UserFirebaseEndpoint.registerNewUser(userName: username)
                .post(data: userModel) { (result: Result<UserModel, Error>) in
                    switch result {
                    case .success(let userInfo):
                        promise(.success(userInfo))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
        }
    }
}
