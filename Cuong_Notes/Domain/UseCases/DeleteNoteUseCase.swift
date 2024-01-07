//
//  DeleteNoteUseCase.swift
//  Cuong_Notes
//
//  Created by Macbook on 07/01/2024.
//

import Foundation
import Combine

protocol DeleteNoteUseCase {
    func execute(noteId: String) -> Future<Void, Error>
}

class DefaultDeleteNoteUseCase: DeleteNoteUseCase {
    
    private let noteRepository: NoteRepository
    
    init(noteRepository: NoteRepository) {
        self.noteRepository = noteRepository
    }
    
    func execute(noteId: String) -> Future<Void, Error> {
        return noteRepository.deleteNote(noteId)
    }
}
