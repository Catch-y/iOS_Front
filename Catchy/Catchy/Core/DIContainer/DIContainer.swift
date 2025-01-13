//
//  SwiftAPITarget.swift
//  Catchy
//
//  Created by 정의찬 on 1/11/25.
//

import Foundation

class DIContainer: ObservableObject {
    let useCaseProvider: UseCaseProvider
    var navigarionRouter: NavigationRoutable & ObservableObjectSettable
    
    init(
        useCaseprovider: UseCaseProvider = UseCaseProvider(),
        navigtionRouter: NavigationRoutable & ObservableObjectSettable = NavigationRouter()
    ) {
        self.useCaseProvider = useCaseprovider
        self.navigarionRouter = navigtionRouter
        self.navigarionRouter.setObjectWillChange(objectWillChange)
    }
}
