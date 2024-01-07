//
//  NoteRepository.swift
//  Cuong_Notes
//
//  Created by Macbook on 05/01/2024.
//

import Foundation
import Combine

protocol NoteRepository {
    func getNotesList(userId: String) -> Future<[NoteModel], Error>
    func addNewNote(for userId: String, title: String, note: String) -> Future<NoteModel, Error>
    func deleteNote(for userId: String, noteId: String) -> Future<Void, Error>
}
