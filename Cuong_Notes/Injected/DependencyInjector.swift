//
//  DependencyInjector.swift
//  Cuong_Notes
//
//  Created by Macbook on 07/01/2024.
//

import Foundation
import Combine
import SwiftUI

// MARK: - DIContainer

struct DIContainer: EnvironmentKey {
    
    let appState: CurrentValueSubject<AppState, Never>
    let repositories: Repositories
    
    init(appState: CurrentValueSubject<AppState, Never>, repositories: Repositories) {
        self.appState = appState
        self.repositories = repositories
    }
    
    init(appState: AppState, repositories: Repositories) {
        self.appState = .init(appState)
        self.repositories = repositories
    }
    
    static var defaultValue: Self { Self.default }
    
    private static let `default` = Self(appState: AppState(), repositories: .stub)
}

extension EnvironmentValues {
    var injected: DIContainer {
        get { self[DIContainer.self] }
        set { self[DIContainer.self] = newValue }
    }
}

#if DEBUG
extension DIContainer {
    static var preview: Self {
        .init(appState: AppState.preview, repositories: .stub)
    }
}
#endif

// MARK: - Injection in the view hierarchy

extension View {
    
    func inject(_ appState: AppState,
                _ repositories: DIContainer.Repositories) -> some View {
        let container = DIContainer(appState: appState,
                                    repositories: repositories)
        return inject(container)
    }
    
    func inject(_ container: DIContainer) -> some View {
        return self
            .environment(\.injected, container)
    }
}
