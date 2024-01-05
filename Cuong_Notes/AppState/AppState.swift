//
//  AppState.swift
//  Cuong_Notes
//
//  Created by Macbook on 04/01/2024.
//

import Foundation
import Combine
import SwiftUI

class AppState: ObservableObject {
    @Published var appRoot: AppRoot = .register
}

enum AppRoot {
    case register
    case note
}
