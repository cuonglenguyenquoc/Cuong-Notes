//
//  FirebaseNoteRepository.swift
//  Cuong_Notes
//
//  Created by Macbook on 05/01/2024.
//

import Foundation
import Combine


class FirebaseNoteRepository: NoteRepository {
    
    func getNotesList(userId: String) -> Future<[NoteModel], Error> {
        Future<[NoteModel], Error> { [weak self] promise in
            guard let self = self else {
                promise(.failure(FirebaseError.other))
                return
            }
            NoteFirebaseEndpoint
                .getNotesList(userId: userId)
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
    
    func addNewNote(for userId: String, title: String, note: String) -> Future<NoteModel, Error> {
        
        Future<NoteModel, Error> { [weak self] promise in
            guard let self = self else {
                promise(.failure(FirebaseError.other))
                return
            }
            let now = Date().timeIntervalSince1970
            let noteModel = NoteModel(id: UUID().uuidString, title: title, text: note, timeStamp: now)
            NoteFirebaseEndpoint
                .addNewNote(userId: userId, noteId: noteModel.id)
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
    
    func deleteNote(for userId: String, noteId: String) -> Future<Void, Error> {
        Future<Void, Error> { [weak self] promise in
            guard let self = self else {
                promise(.failure(FirebaseError.other))
                return
            }
            NoteFirebaseEndpoint
                .deleteNote(userId: userId, noteId: noteId)
                .remove(completion: {( result: Result<Void, Error>) in
                    switch result {
                    case .success(_):
                        promise(.success(()))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                })
        }
    }
}
