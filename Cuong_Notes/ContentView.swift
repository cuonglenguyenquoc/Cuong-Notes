//
//  ContentView.swift
//  Cuong_Notes
//
//  Created by Macbook on 03/01/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.ui.background
                    .ignoresSafeArea()
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("Hello, world!")
                        .border(Color.gray)
                        .frame(width: 100)
                        
                }
                .background(Color.red)
                .padding()
                .navigationTitle("Notes")
                .toolbar {
                    ToolbarItem() {
                        Button(action: {
                            
                        }) {
                            Image("people_white")
                        }
                    }
                }
            }
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

