//
//  NoteModel.swift
//  Cuong_Notes
//
//  Created by Macbook on 05/01/2024.
//

import Foundation

struct NoteModel: Identifiable, Codable {
    var id: String
    var text: String
    var timeStamp: TimeInterval
}
