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
    private var userModel: UserModel
    
    init(userModel: UserModel) {
        self.userModel = userModel
        let repository = FirebaseNoteRepository(userModel: userModel)
        let useCase = DefaultGetNotesListUseCase(noteRepository: repository)
        self._viewModel = StateObject(wrappedValue: UserListNodeViewModel(getNotesListUseCase: useCase))
    }
    var body: some View {
        NavigationStack {
            ZStack {
                Color.ui.background
                    .ignoresSafeArea()
                if viewState == .fetching {
                    ActivityIndicatorView()
                } else {
                    Image("image_search")
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
                Button(
                    action: {
                        viewModel.addNewNoteButtonTapped()
                    },
                    label: {
                        Image(systemName: "plus")
                            .resizable()
                            .padding()
                            .frame(width: 50, height: 50)
                            .background(.mint)
                            .clipShape(Circle())
                            .foregroundColor(.white)
                    }
                )
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

