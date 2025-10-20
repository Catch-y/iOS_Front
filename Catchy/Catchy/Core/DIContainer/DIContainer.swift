//
//  DIContainer.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/18/25.
//

import Foundation

class DIContainer: ObservableObject {
    @Published var navigationRouter: NavigationRoutable
    @Published var useCaseProvider: UseCaseProtocol
    
    init(
        navigationRouter: NavigationRoutable = NavigationRouter(),
        useCaseProvider: UseCaseProtocol = UseCaseProvider()
    ) {
        self.navigationRouter = navigationRouter
        self.useCaseProvider = useCaseProvider
    }
}
