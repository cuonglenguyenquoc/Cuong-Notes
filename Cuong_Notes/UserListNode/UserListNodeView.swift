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
    @Environment(\.injected) private var injected: DIContainer
    
    // MARK: - Views
    var body: some View {
        if let userModel = injected.appState.value.userInfo {
            ContentView(viewModel: UserListNodeViewModel(noteRepository: injected.repositories.noteRepository, userModel: userModel))
        } else {
            Text("Something was wrong")
        }
    }
    
    private struct ContentView: View {
        @Environment(\.injected) private var injected: DIContainer
        @StateObject var viewModel: UserListNodeViewModel
        
        var body: some View {
            NavigationView {
                ZStack {
                    Color.ui.background
                        .ignoresSafeArea()
                    switch viewModel.viewState {
                    case .fetching:
                        ActivityIndicatorView()
                    case .empty:
                        emptyView()
                    case .notes:
                        listNotes()
                    }
                    addNoteButton()
                }
                .navigationTitle(injected.appState.value.userInfo?.userName ?? "")
                .onAppear {
                    viewModel.onAppear()
                }
            }
        }
        
        @ViewBuilder
        private func emptyView() -> some View {
            VStack {
                Image("image_search")
                Text("Create your first note!")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(Color.white)
            }
        }
        
        @ViewBuilder
        private func listNotes() -> some View {
            List(viewModel.noteModels) { noteModel in
                return NoteRow(noteModel: noteModel, deleteHandler: { noteModel in
                    self.viewModel.deleteNote(noteModel)
                })
            }
            .lineSpacing(16)
            .frame(maxWidth: .infinity)
            .listStyle(GroupedListStyle())
        }
        
        @ViewBuilder
        private func addNoteButton() -> some View {
            VStack(spacing: 0) {
                Spacer()
                
                HStack(spacing: 0) {
                    Spacer()
                    NavigationLink(destination: NoteCreatorView(addNoteSuccessHandler: addNoteSuccessHandler)) {
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
            return { [weak viewModel] in
                viewModel?.refresh()
            }
        }
    }
}

struct UserListNodeView_Previews: PreviewProvider {
    static var previews: some View {
        UserListNodeView()
    }
}
