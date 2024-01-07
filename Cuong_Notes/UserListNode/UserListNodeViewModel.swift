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
    func deleteNote(_ noteModel: NoteModel)
}

class UserListNodeViewModel: ObservableObject, UserListNodeViewModelInput, UserListNodeViewModelOutput {
    
    // MARK: - Outputs
    @Published
    var noteModels: [NoteModel] = []
    
    @Published
    var viewState: ViewState = .fetching
    
    // MARK: - Instance Variables
    private var subscriptions = Set<AnyCancellable>()
    
    let noteRepository: NoteRepository
    let userModel: UserModel
    
    // MARK: - Init
    init(noteRepository: NoteRepository, userModel: UserModel) {
        self.noteRepository = noteRepository
        self.userModel = userModel
    }
    
    private func fetchNotesList() {
        noteRepository
            .getNotesList(userId: userModel.id)
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] noteModels in
                self?.viewState = noteModels.isEmpty ? .empty : .notes
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
    
    func deleteNote(_ noteModel: NoteModel) {
        noteRepository
            .deleteNote(for: userModel.id, noteId: noteModel.id)
            .sink { completion in
                // TODO: cuonglnq - handle error
            } receiveValue: { [weak self] _ in
                self?.refresh()
            }
            .store(in: &subscriptions)
    }
}

extension UserListNodeViewModel {
    enum ViewState {
        case fetching
        case empty
        case notes
    }
}
