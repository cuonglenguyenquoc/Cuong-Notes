//
//  UserListNodeViewModel.swift
//  Cuong_Notes
//
//  Created by Macbook on 05/01/2024.
//

import Foundation
import Combine

protocol UserListNodeViewModelOutput {
    var noteModels: [NoteModel] { get }
    var viewState: UserListNodeViewModel.ViewState { get }
    
}

protocol UserListNodeViewModelInput {
    func onAppear()
    func refresh()
}

class UserListNodeViewModel: ObservableObject, UserListNodeViewModelInput, UserListNodeViewModelOutput {
    
    // MARK: - Outputs
    @Published
    var noteModels: [NoteModel] = []
    
    @Published
    var viewState: ViewState = .fetching
    
    // MARK: - Instance Variables
    private var subscriptions = Set<AnyCancellable>()
    
    private let getNotesListUseCase: GetNotesListUseCase
    
    // MARK: - Init
    init(getNotesListUseCase: GetNotesListUseCase) {
        self.getNotesListUseCase = getNotesListUseCase
    }
    
    private func fetchNotesList() {
        getNotesListUseCase
            .execute()
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] noteModels in
                self?.viewState = .finished
                self?.noteModels = noteModels
            })
            .store(in: &subscriptions)
    }
    
    // MARK: - Inputs
    func onAppear() {
        fetchNotesList()
    }
    
    func refresh() {
        fetchNotesList()
    }
}

extension UserListNodeViewModel {
    enum ViewState {
        case fetching
        case finished
    }
}
