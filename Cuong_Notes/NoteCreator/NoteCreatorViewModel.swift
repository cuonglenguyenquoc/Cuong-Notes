//
//  NoteCreatorViewModel.swift
//  Cuong_Notes
//
//  Created by Macbook on 06/01/2024.
//

import Foundation
import Combine

protocol NoteCreatorViewModelOutput {
    var errorSubject: CurrentValueSubject<String?, Never> { get }
    var createNoteSuccessSubject: PassthroughSubject<Void, Never> { get }
    
}

protocol NoteCreatorViewModelInput {
    func saveNoteButtonTapped(title: String, note: String)
}

class NoteCreatorViewModel: ObservableObject, NoteCreatorViewModelInput, NoteCreatorViewModelOutput {
    
    // MARK: - Outputs
    var errorSubject: CurrentValueSubject<String?, Never> = .init(nil)
    var createNoteSuccessSubject: PassthroughSubject<Void, Never> = .init()
    
    // MARK: - Instance Variables
    private var subscriptions = Set<AnyCancellable>()
    
    private let addNewNoteUseCase: AddNewNoteUseCase
    
    // MARK: - Init
    init(addNewNoteUseCase: AddNewNoteUseCase) {
        self.addNewNoteUseCase = addNewNoteUseCase
    }
    
    // MARK: - Inputs
    
    func saveNoteButtonTapped(title: String, note: String) {
        if title.isEmpty || note.isEmpty {
            errorSubject.send("Please provide values for title and description")
            return
        }
        addNewNoteUseCase
            .execute(title: title, note: note)
            .sink { [weak self] completion in
                if case .failure(_) = completion {
                    self?.errorSubject.send("Server error")
                }
            } receiveValue: { [weak self] _ in
                self?.createNoteSuccessSubject.send(())
            }
            .store(in: &subscriptions)
    }
}
