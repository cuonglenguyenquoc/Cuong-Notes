//
//  NoteCreatorView.swift
//  Cuong_Notes
//
//  Created by Macbook on 06/01/2024.
//

import SwiftUI

struct NoteCreatorView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: NoteCreatorViewModel
    @State private var title: String = ""
    @State private var note: String = ""
    @State private var isShowingError: Bool = false
    private var userModel: UserModel
    private var addNoteSuccessHandler: (()->())?
    
    init(userModel: UserModel, addNoteSuccessHandler: (()->())?) {
        self.userModel = userModel
        self.addNoteSuccessHandler = addNoteSuccessHandler
        let repository = FirebaseNoteRepository(userModel: userModel)
        let useCase = DefaultAddNewNoteUseCase(noteRepository: repository)
        self._viewModel = StateObject(wrappedValue: NoteCreatorViewModel(addNewNoteUseCase: useCase))
    }
    
    var body: some View {
        VStack() {
            titleTextField()
            Divider()
                .background(Color.white)
            noteTextEditor()
        }
        .padding(24)
        .toolbar {
            ToolbarItem() {
                saveToolBarItem()
            }
        }
        .onReceive(viewModel.errorSubject, perform: { newValue in
            self.isShowingError = newValue != nil
            
        })
        .onReceive(viewModel.createNoteSuccessSubject, perform: { _ in
            self.dismiss()
        })
        .alert(isPresented: $isShowingError, content: {
            Alert(title: Text("Something went wrong"), message: Text(viewModel.errorSubject.value ?? ""))
        })
    }
    
    @ViewBuilder
    private func saveToolBarItem() -> some View {
        Button(action: {
            viewModel.saveNoteButtonTapped(title: title, note: note)
        }) {
            HStack {
                Image("icon_save")
                Spacer()
            }
        }
        .padding(8)
        .background(Color(hex: "3B3B3B"))
        .cornerRadius(16)
    }
    
    @ViewBuilder
    private func titleTextField() -> some View {
        TextField("Title", text: $title, onCommit: {
            hideKeyboard()
        })
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(Color.white)
            .background(Color.clear)
            .padding(.bottom, 24)
            .autocorrectionDisabled()
    }
    
    @ViewBuilder
    private func noteTextEditor() -> some View {
        TextEditor(text: $note)
            .font(.system(size: 22, weight: .regular))
            .placeholder(when: note.isEmpty, alignment: .topLeading, placeholder: {
                Text("Type something...")
                    .font(.system(size: 22, weight: .regular))
                    .foregroundColor(Color(hex: "464649"))
                    .padding(4)
            })
            .autocorrectionDisabled()
            
    }
}

struct NoteCreatorView_Previews: PreviewProvider {
    static var previews: some View {
        NoteCreatorView(userModel: UserModel(id: "", userName: ""), addNoteSuccessHandler: nil)
    }
}
