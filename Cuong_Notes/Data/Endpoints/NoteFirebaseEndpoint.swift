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
    
    
    var path: String {
        switch self {
        case .addNewNote(let userId, let noteId):
            return "users/\(userId)/notes/\(noteId)"
        case .getNotesList(let userId):
            return "users/\(userId)/notes"
        }
    }
    
    var synced: Bool {
        return true
    }
}
