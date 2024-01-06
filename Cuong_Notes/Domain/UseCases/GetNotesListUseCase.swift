//
//  GetNotesListUseCase.swift
//  Cuong_Notes
//
//  Created by Macbook on 05/01/2024.
//

import Foundation
import Combine

protocol GetNotesListUseCase {
    func execute() -> Future<[NoteModel], Error>
}

class DefaultGetNotesListUseCase: GetNotesListUseCase {
    
    private let noteRepository: NoteRepository
    
    init(noteRepository: NoteRepository) {
        self.noteRepository = noteRepository
    }
    
    func execute() -> Future<[NoteModel], Error> {
        return noteRepository.getNotesList()
    }
}
