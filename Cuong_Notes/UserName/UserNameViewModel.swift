//
//  UserNameViewModel.swift
//  Cuong_Notes
//
//  Created by Macbook on 03/01/2024.
//

import Foundation
import Combine

protocol UserNameViewModelOutput {
    var onRegisterErrorSubject: PassthroughSubject<Void, Never> { get }
    var onRegisterSuccessSubject: PassthroughSubject<Void, Never> { get }
}

protocol UserNameViewModelInput {
    func registerUser(with userName: String)
}

class UserNameViewModel: ObservableObject, UserNameViewModelInput, UserNameViewModelOutput {
    
    var onRegisterErrorSubject: PassthroughSubject<Void, Never> = .init()
    
    var onRegisterSuccessSubject: PassthroughSubject<Void, Never> = .init()
    
    private var subscriptions = Set<AnyCancellable>()
    
    private let registerUserUseCase: RegisterUserUseCase
    
    init(registerUserUseCase: RegisterUserUseCase) {
        self.registerUserUseCase = registerUserUseCase
    }
    
    func registerUser(with userName: String) {
        registerUserUseCase
            .execute(requestValue: userName)
            .sink { [weak self] completion in
                if case .failure(_) = completion {
                    self?.onRegisterErrorSubject.send(())
                    print("error")
                }
            } receiveValue: { [weak self] userModel in
                self?.onRegisterSuccessSubject.send(())
                print("success")
            }
            .store(in: &subscriptions)
    }
}
