//
//  UserListNodeView.swift
//  Cuong_Notes
//
//  Created by Macbook on 04/01/2024.
//

import Foundation
import SwiftUI

struct UserListNodeView: View {
    @Environment(\.injected) private var injected: DIContainer
    
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
                .navigationTitle(injected.appState.value.userInfo?.userName ?? "")
                .toolbar {
                    ToolbarItem() {
                        Button(action: {
                            
                        }) {
                            HStack {
                                Image("people_white")
                                Spacer()
                            }
                        }
                        .padding(8)
                        .background(Color(hex: "3B3B3B"))
                        .cornerRadius(16)
                    }
                }
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
            return {
                self.viewModel.refresh()
            }
        }
    }
}

struct UserListNodeView_Previews: PreviewProvider {
    static var previews: some View {
        UserListNodeView()
    }
}


struct NoteRow : View {
    var noteModel: NoteModel
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(Date(timeIntervalSince1970: noteModel.timeStamp).toString())
                .font(.headline)
            Text(noteModel.title)
                .font(.title)
                .fontWeight(.bold)
            Text(noteModel.text)
                .font(.body)
                .fontWeight(.regular)
            }
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundColor(.black)
        .padding(16)
        .background(Color(hex: noteModel.color))
        .cornerRadius(16)
    }
}
