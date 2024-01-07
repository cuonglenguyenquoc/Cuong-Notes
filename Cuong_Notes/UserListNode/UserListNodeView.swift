//
//  UserListNodeView.swift
//  Cuong_Notes
//
//  Created by Macbook on 04/01/2024.
//

import Foundation
import SwiftUI

struct UserListNodeView: View {
    // MARK: - Variables
    @StateObject var viewModel: UserListNodeViewModel
    private var userModel: UserModel
    
    // MARK: - Init
    init(userModel: UserModel) {
        self.userModel = userModel
        let repository = FirebaseNoteRepository(userModel: userModel)
        let useCase = DefaultGetNotesListUseCase(noteRepository: repository)
        self._viewModel = StateObject(wrappedValue: UserListNodeViewModel(getNotesListUseCase: useCase))
    }
    
    // MARK: - Views
    var body: some View {
        NavigationView {
            ZStack {
                Color.ui.background
                    .ignoresSafeArea()
                if viewModel.viewState == .fetching {
                    ActivityIndicatorView()
                } else {
                    if viewModel.noteModels.isEmpty {
                        VStack {
                            Image("image_search")
                            Text("Create your first note!")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(Color.white)
                        }
                    } else {
                        List(viewModel.noteModels) { noteModel in
                            return NoteRow(noteModel: noteModel)
                        }
                        .lineSpacing(16)
                        .frame(maxWidth: .infinity)
                        .listStyle(GroupedListStyle())
                    }
                }
                
                addNoteButton()
            }
            .navigationTitle(userModel.userName)
            .onAppear {
                viewModel.onAppear()
            }
        }
    }
    
    @ViewBuilder
    private func addNoteButton() -> some View {
        VStack(spacing: 0) {
            Spacer()
            
            HStack(spacing: 0) {
                Spacer()
                NavigationLink(destination: NoteCreatorView(userModel: userModel, addNoteSuccessHandler: addNoteSuccessHandler)) {
                    Image(systemName: "plus")
                        .resizable()
                        .padding()
                        .frame(width: 50, height: 50)
                        .background(.mint)
                        .clipShape(Circle())
                        .foregroundColor(.white)
                }
                .padding(30)
            }
        }
    }
    
    private var addNoteSuccessHandler: (()->())? {
        return { 
            self.viewModel.refresh()
        }
    }
}

struct UserListNodeView_Previews: PreviewProvider {
    static var previews: some View {
        UserListNodeView(userModel: UserModel(id: "", userName: ""))
    }
}
