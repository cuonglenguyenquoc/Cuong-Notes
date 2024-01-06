//
//  NoteFirebaseEndpoint.swift
//  Cuong_Notes
//
//  Created by Macbook on 05/01/2024.
//

import Foundation
import UIKit

enum NoteFirebaseEndpoint: FirebaseDatabaseEndpoint {
    
    case addNewNote(userId: String)
    case getNotesList(userId: String)
    
    
    var path: String {
        switch self {
        case .addNewNote(let userId):
            return "users/\(userId)"
        case .getNotesList(let userId):
            return "users/\(userId)/notes"
        }
    }
    
    var synced: Bool {
        return true
    }
}
