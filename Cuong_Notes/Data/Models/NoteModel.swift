//
//  NoteModel.swift
//  Cuong_Notes
//
//  Created by Macbook on 05/01/2024.
//

import Foundation

struct NoteModel: Identifiable, Codable {
    var id: String
    var title: String
    var text: String
    var timeStamp: TimeInterval
    var color: String
    
    init(id: String = UUID().uuidString, title: String, text: String, timeStamp: TimeInterval = Date().timeIntervalSince1970, color: String = Self.getRandomHexColor()) {
        self.id = id
        self.title = title
        self.text = text
        self.timeStamp = timeStamp
        self.color = color
    }
    
    static func getRandomHexColor() -> String {
        let colors: [String] = ["FD99FF", "FF9E9E", "91F48F", "FFF599", "9EFFFF", "B69CFF"]
        return colors.randomElement() ?? "FD99FF"
    }
}
