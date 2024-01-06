//
//  UserListNodeViewModel.swift
//  Cuong_Notes
//
//  Created by Macbook on 05/01/2024.
//

import Foundation
import Combine

protocol UserListNodeViewModelOutput {
    var notesSubject: CurrentValueSubject<[NoteModel], Never> { get }
    var viewStateSubject: CurrentValueSubject<UserListNodeViewModel.ViewState, Never> { get }
    
}

protocol UserListNodeViewModelInput {
    func onAppear()
    func addNewNoteButtonTapped()
}

class UserListNodeViewModel: ObservableObject, UserListNodeViewModelInput, UserListNodeViewModelOutput {
    
    // MARK: - Outputs
    var notesSubject: CurrentValueSubject<[NoteModel], Never> = .init([])
    
    var viewStateSubject: CurrentValueSubject<ViewState, Never> = .init(.fetching)
    
    // MARK: - Instance Variables
    private var subscriptions = Set<AnyCancellable>()
    
    private let getNotesListUseCase: GetNotesListUseCase
    
    // MARK: - Init
    init(getNotesListUseCase: GetNotesListUseCase) {
        self.getNotesListUseCase = getNotesListUseCase
    }
    
    // MARK: - Inputs
    func onAppear() {
        getNotesListUseCase
            .execute()
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] noteModels in
                self?.viewStateSubject.send(.finished)
                self?.notesSubject.send(noteModels)
            })
            .store(in: &subscriptions)
    }
    
    func addNewNoteButtonTapped() {
        
    }
}

extension UserListNodeViewModel {
    enum ViewState {
        case fetching
        case finished
    }
}
