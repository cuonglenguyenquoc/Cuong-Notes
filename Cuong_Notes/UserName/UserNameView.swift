//
//  UserNameView.swift
//  Cuong_Notes
//
//  Created by Macbook on 03/01/2024.
//

import Foundation
import SwiftUI
import UIKit

struct UserNameView: View {
    @StateObject var viewModel = UserNameViewModel(getUserInfoUseCase: DefaultGetUserInfoUseCase(userRepository: FirebaseUserRepository()), registerUserUseCase: DefaultRegisterUserUseCase(userRepository: FirebaseUserRepository()))
    @EnvironmentObject var appState: AppState
    
    @State private var name: String = ""
    
    var body: some View {
        
        ZStack {
            Color.ui.background
                .ignoresSafeArea()
            VStack {
                Text("Notes App")
                    .font(.system(size: 30, weight: .bold, design: .serif))
                    .foregroundColor(.white)
                Image("image_notebook")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200, alignment: .center)
                    
                if viewModel.shouldShowInputField {
                    nameTextField()
                    startButton()
                } else {
                    ActivityIndicatorView()
                }
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
        .onReceive(viewModel.onMoveToNoteSubject) { userModel in
            self.appState.appRoot = .note(userModel)
        }
    }
    
    @ViewBuilder
    private func nameTextField() -> some View {
        TextField("Please input your username", text: $name, onCommit: {
            hideKeyboard()
        })
            .textFieldStyle(.roundedBorder)
            .foregroundColor(.black)
            .background(Color.white.opacity(0.2))
            .padding(24)
            .colorScheme(.light)
    }
    
    @ViewBuilder
    private func startButton() -> some View {
        Button("Start!!!") {
            hideKeyboard()
            viewModel.registerUser(with: name)
        }
        .frame(width: 160, height: 40)
        .fontWeight(.bold)
        .background(Color.blue.opacity(name.isEmpty ? 0.5 : 0.7))
        .foregroundColor(name.isEmpty ? Color.gray : Color.white)
        .cornerRadius(8)
        .disabled(name.isEmpty)
    }
}

struct UserNameView_Previews: PreviewProvider {
    static var previews: some View {
        UserNameView()
    }
}

