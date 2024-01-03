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
    
    @State var name: String = ""
    
    var body: some View {
        
        ZStack {
            Color.ui.background
                .ignoresSafeArea()
            
            VStack {
                Text("Notes App")
                    .font(.system(size: 30, weight: .bold, design: .serif))
                    .foregroundColor(.white)
                nameTextField()
                startButton()
            }
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
    }
    
    @ViewBuilder
    private func startButton() -> some View {
        Button("Start!!!") {
            hideKeyboard()
        }
        .frame(width: 80, height: 40)
        .fontWeight(.bold)
        .background(Color.blue.opacity(name.isEmpty ? 0.3 : 0.7))
        .foregroundColor(name.isEmpty ? Color.gray : Color.white)
        .cornerRadius(20)
        .disabled(name.isEmpty)
    }
}

struct UserNameView_Previews: PreviewProvider {
    static var previews: some View {
        UserNameView()
    }
}

