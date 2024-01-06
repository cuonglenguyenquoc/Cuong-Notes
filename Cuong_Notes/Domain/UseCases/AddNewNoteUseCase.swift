//
//  AddNewNoteUseCase.swift
//  Cuong_Notes
//
//  Created by Macbook on 05/01/2024.
//

import Foundation
import Combine

protocol AddNewNoteUseCase {
    func execute(requestValue: String) -> Future<NoteModel, Error>
}

class DefaultAddNewNoteUseCase: AddNewNoteUseCase {
    
    private let noteRepository: NoteRepository
    
    init(noteRepository: NoteRepository) {
        self.noteRepository = noteRepository
    }
    
    func execute(requestValue: String) -> Future<NoteModel, Error> {
        return noteRepository.addNewNote(with: requestValue)
    }
}
