//
//  AppState.swift
//  Cuong_Notes
//
//  Created by Macbook on 04/01/2024.
//

import Foundation
import Combine
import SwiftUI

struct AppState {
    var appRoot: AppRoot = .register
    var userInfo: UserModel?
}

enum AppRoot {
    case register
    case note
}

#if DEBUG
extension AppState {
    static var preview: AppState {
        var state = AppState()
        state.userInfo = UserModel(id: "", userName: "Cuong_Notes")
        return state
    }
}
#endif
