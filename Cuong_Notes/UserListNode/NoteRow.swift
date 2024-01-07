//
//  NoteRow.swift
//  Cuong_Notes
//
//  Created by Macbook on 07/01/2024.
//

import Foundation
import SwiftUI

struct NoteRow: View {
    var noteModel: NoteModel
    var deleteHandler: ((NoteModel) -> ())?
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(Date(timeIntervalSince1970: noteModel.timeStamp).toString())
                    .font(.headline)
                Text(noteModel.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .lineSpacing(2)
                Text(noteModel.text)
                    .font(.body)
                    .fontWeight(.regular)
                    .lineSpacing(2)
                }
            .foregroundColor(.black)
            Spacer()
            Button {
                self.deleteHandler?(noteModel)
            } label: {
                Image("icon_delete")
                    .resizable()
                    .frame(width: 28, height: 28)
            }
            .buttonStyle(PlainButtonStyle())
        }
        
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(Color(hex: noteModel.color))
        .cornerRadius(16)
    }
}
