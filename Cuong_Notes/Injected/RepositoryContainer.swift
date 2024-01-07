//
//  RepositoryContainer.swift
//  Cuong_Notes
//
//  Created by Macbook on 07/01/2024.
//

import Foundation

extension DIContainer {
    struct Repositories {
        let userRepository: UserRepository
        let noteRepository: NoteRepository
        
        init(userRepository: UserRepository,
             noteRepository: NoteRepository) {
            self.userRepository = userRepository
            self.noteRepository = noteRepository
        }
        
        static var stub: Self {
            .init(userRepository: FirebaseUserRepository(),
                  noteRepository: FirebaseNoteRepository())
        }
    }
}
