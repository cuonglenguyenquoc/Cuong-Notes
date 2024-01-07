//
//  UserNameViewModel.swift
//  Cuong_Notes
//
//  Created by Macbook on 03/01/2024.
//

import Foundation
import Combine

protocol UserNameViewModelOutput {
    var shouldShowInputField: Bool { get }
    var onRegisterErrorSubject: PassthroughSubject<Void, Never> { get }
    var onMoveToNoteSubject: PassthroughSubject<UserModel, Never> { get }
}

protocol UserNameViewModelInput {
    func onAppear()
    func registerUser(with userName: String)
}

class UserNameViewModel: ObservableObject, UserNameViewModelInput, UserNameViewModelOutput {
    
    // MARK: - Outputs
    @Published
    var shouldShowInputField: Bool = false
    
    var onRegisterErrorSubject: PassthroughSubject<Void, Never> = .init()
    
    var onMoveToNoteSubject: PassthroughSubject<UserModel, Never> = .init()
    
    // MARK: - Variables
    private var subscriptions = Set<AnyCancellable>()
    
    private let userRepository: UserRepository
    
    // MARK: - Init
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    // MARK: - Inputs
    func onAppear() {
        userRepository
            .getUserInfo()
            .delay(for: 1, scheduler: RunLoop.main)
            .sink { [weak self] completion in
                if case .failure(_) = completion {
                    self?.shouldShowInputField = true
                }
            } receiveValue: { [weak self] userModel in
                if let userModel = userModel {
                    self?.shouldShowInputField = false
                    self?.onMoveToNoteSubject.send((userModel))
                } else {
                    self?.shouldShowInputField = true
                }
            }
            .store(in: &subscriptions)
    }
    
    func registerUser(with userName: String) {
        userRepository
            .registerNewUser(with: userName)
            .sink { [weak self] completion in
                if case .failure(_) = completion {
                    self?.onRegisterErrorSubject.send(())
                }
            } receiveValue: { [weak self] userModel in
                self?.onMoveToNoteSubject.send(userModel)
            }
            .store(in: &subscriptions)
    }
}
