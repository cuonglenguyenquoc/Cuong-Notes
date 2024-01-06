//
//  UserListNodeView.swift
//  Cuong_Notes
//
//  Created by Macbook on 04/01/2024.
//

import Foundation
import SwiftUI

struct UserListNodeView: View {
    @StateObject var viewModel: UserListNodeViewModel
    @State private var viewState: UserListNodeViewModel.ViewState = .fetching
    @State private var isShowingNoteCreatorView = false
    private var userModel: UserModel
    
    init(userModel: UserModel) {
        self.userModel = userModel
        let repository = FirebaseNoteRepository(userModel: userModel)
        let useCase = DefaultGetNotesListUseCase(noteRepository: repository)
        self._viewModel = StateObject(wrappedValue: UserListNodeViewModel(getNotesListUseCase: useCase))
    }
    var body: some View {
        NavigationView {
            ZStack {
                Color.ui.background
                    .ignoresSafeArea()
                if viewState == .fetching {
                    ActivityIndicatorView()
                } else {
                    if viewModel.notesSubject.value.isEmpty {
                        VStack {
                            Image("image_search")
                            Text("Create your first note!")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(Color.white)
                        }
                    } else {
                        ForEach(viewModel.notesSubject.value, content: { noteModel in
                            return Text(noteModel.title)
                        })
                    }
                }
                
                addNoteButton()
            }
            .navigationTitle(userModel.userName)
            .toolbar {
                ToolbarItem() {
                    Button(action: {
                        
                    }) {
                        Image("people_white")
                    }
                    .padding(8)
                    .background(Color(hex: "3B3B3B"))
                    .cornerRadius(16)
                }
            }
            .onAppear {
                viewModel.onAppear()
            }
            .onReceive(viewModel.viewStateSubject) { self.viewState = $0 }
        }
    }
    
    @ViewBuilder
    private func addNoteButton() -> some View {
        VStack(spacing: 0) {
            Spacer()
            
            HStack(spacing: 0) {
                Spacer()
                NavigationLink(destination: NoteCreatorView(userModel: userModel)) {
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
}

struct UserListNodeView_Previews: PreviewProvider {
    static var previews: some View {
        UserListNodeView(userModel: UserModel(id: "", userName: ""))
    }
}

