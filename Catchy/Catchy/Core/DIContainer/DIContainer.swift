//
//  SwiftAPITarget.swift
//  Catchy
//
//  Created by 정의찬 on 1/11/25.
//

import Foundation

class DIContainer: ObservableObject {
    let useCaseProvider: UseCaseProvider
    var navigationRouter: NavigationRoutable & ObservableObjectSettable
    
    init(
        useCaseprovider: UseCaseProvider = UseCaseProvider(),
        navigationRouter: NavigationRoutable & ObservableObjectSettable = NavigationRouter()
    ) {
        self.useCaseProvider = useCaseprovider
        self.navigationRouter = navigationRouter
        self.navigationRouter.setObjectWillChange(objectWillChange)
    }
}
