//
//  FirebaseNoteRepository.swift
//  Cuong_Notes
//
//  Created by Macbook on 05/01/2024.
//

import Foundation
import Combine

class FirebaseNoteRepository: NoteRepository {
    
    let userModel: UserModel
    init(userModel: UserModel) {
        self.userModel = userModel
    }
    
    func getNotesList() -> Future<[NoteModel], Error> {
        Future<[NoteModel], Error> { [weak self] promise in
            guard let self = self else {
                promise(.failure(FirebaseError.other))
                return
            }
            NoteFirebaseEndpoint
                .getNotesList(userId: userModel.id)
                .retrieve { (result: Result<[NoteModel], Error>) in
                    switch result {
                    case .success(let noteModels):
                        promise(.success(noteModels))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
        }
    }
    
    func addNewNote(with title: String, note: String) -> Future<NoteModel, Error> {
        
        Future<NoteModel, Error> { [weak self] promise in
            guard let self = self else {
                promise(.failure(FirebaseError.other))
                return
            }
            let now = Date().timeIntervalSince1970
            let noteModel = NoteModel(id: UUID().uuidString, title: title, text: note, timeStamp: now)
            NoteFirebaseEndpoint
                .addNewNote(userId: userModel.id, noteId: noteModel.id)
                .post(data: noteModel) { (result: Result<NoteModel, Error>) in
                    switch result {
                    case .success(let noteModel):
                        promise(.success(noteModel))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
        }
    }
}
