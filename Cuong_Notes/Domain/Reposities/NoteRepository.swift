//
//  NoteRepository.swift
//  Cuong_Notes
//
//  Created by Macbook on 05/01/2024.
//

import Foundation
import Combine

protocol NoteRepository {
    func getNotesList() -> Future<[NoteModel], Error>
    func addNewNote(with title: String, note: String) -> Future<NoteModel, Error>
    func deleteNote(_ noteId: String) -> Future<Void, Error>
}
