//
//  Cuong_NotesApp.swift
//  Cuong_Notes
//
//  Created by Macbook on 03/01/2024.
//

import SwiftUI

@main
struct Cuong_NotesApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    private let container = DIContainer.defaultValue
    @State
    private var currentAppRoot: AppRoot = .register
    
    init() {
        FirebaseDatabaseManager.shared.configure()
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some Scene {
        WindowGroup {
            rootView
                .preferredColorScheme(.dark)
                .inject(container)
                .onReceive(container.appState) { appState in
                    self.currentAppRoot = appState.appRoot
                }
        }
    }
    
    @ViewBuilder
    private var rootView: some View {
        switch currentAppRoot {
        case .register:
            UserNameView()
        case .note:
            UserListNodeView()
        }
    }
}
