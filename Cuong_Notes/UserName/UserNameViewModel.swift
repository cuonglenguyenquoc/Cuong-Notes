//
//  UserNameViewModel.swift
//  Cuong_Notes
//
//  Created by Macbook on 03/01/2024.
//

import Foundation
import Combine

protocol UserNameViewModelOutput {
    var onShowUserNameInputSubject: PassthroughSubject<Bool, Never> { get }
    var onRegisterErrorSubject: PassthroughSubject<Void, Never> { get }
    var onMoveToNoteSubject: PassthroughSubject<Void, Never> { get }
}

protocol UserNameViewModelInput {
    func onAppear()
    func registerUser(with userName: String)
}

class UserNameViewModel: ObservableObject, UserNameViewModelInput, UserNameViewModelOutput {
    
    var onShowUserNameInputSubject: PassthroughSubject<Bool, Never> = .init()
    
    var onRegisterErrorSubject: PassthroughSubject<Void, Never> = .init()
    
    var onMoveToNoteSubject: PassthroughSubject<Void, Never> = .init()
    
    private var subscriptions = Set<AnyCancellable>()
    
    private let registerUserUseCase: RegisterUserUseCase
    private let getUserInfoUseCase: GetUserInfoUseCase
    
    init(getUserInfoUseCase: GetUserInfoUseCase, registerUserUseCase: RegisterUserUseCase) {
        self.getUserInfoUseCase = getUserInfoUseCase
        self.registerUserUseCase = registerUserUseCase
    }
    
    func onAppear() {
        getUserInfoUseCase
            .execute()
            .sink { [weak self] completion in
                if case .failure(_) = completion {
                    self?.onShowUserNameInputSubject.send(true)
                }
            } receiveValue: { [weak self] userModel in
                if let userModel = userModel {
                    self?.onShowUserNameInputSubject.send(false)
                    self?.onMoveToNoteSubject.send(())
                } else {
                    self?.onShowUserNameInputSubject.send(true)
                }
            }
            .store(in: &subscriptions)
    }
    
    func registerUser(with userName: String) {
        registerUserUseCase
            .execute(requestValue: userName)
            .sink { [weak self] completion in
                if case .failure(_) = completion {
                    self?.onRegisterErrorSubject.send(())
                }
            } receiveValue: { [weak self] userModel in
                self?.onMoveToNoteSubject.send(())
            }
            .store(in: &subscriptions)
    }
}
