//
//  NoteFirebaseEndpoint.swift
//  Cuong_Notes
//
//  Created by Macbook on 05/01/2024.
//

import Foundation
import UIKit

enum NoteFirebaseEndpoint: FirebaseDatabaseEndpoint {
    
    case addNewNote(userId: String, noteId: String)
    case getNotesList(userId: String)
    case deleteNote(userId: String, noteId: String)
    
    var path: String {
        switch self {
        case .addNewNote(let userId, let noteId):
            return "users/\(userId)/notes/\(noteId)"
        case .getNotesList(let userId):
            return "users/\(userId)/notes"
        case .deleteNote(let userId, let noteId):
            return "users/\(userId)/notes/\(noteId)"
        }
    }
    
    var synced: Bool {
        return true
    }
}
