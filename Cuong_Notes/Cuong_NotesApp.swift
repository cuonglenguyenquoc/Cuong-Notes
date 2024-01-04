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
    private let getUserInfoUseCase: GetUserInfoUseCase
    
    init() {
        FirebaseDatabaseManager.shared.configure()
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        getUserInfoUseCase = DefaultGetUserInfoUseCase(userReposity: FirebaseUserReposity())
        
        
    }
    
    var body: some Scene {
        WindowGroup {
            UserNameView()
        }
    }
}
