//
//  PreferenceViewModel.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/19/25.
//

import Foundation

@Observable
class PreferenceViewModel {
    
    // MARK: - Property
    let nickname: String = UserDefaults.standard.string(forKey: AppStorageKey.userNickname) ?? "정보 없음"
    var preferencPage: PageType
    var bigCategoryBtn: [CategoryType] = .init()
    
    // MARK: - Dependency
    let container: DIContainer
    let appFlow: AppFlow
    
    // MARK: - Init
    init(container: DIContainer, appFlow: AppFlow) {
        self.container = container
        self.appFlow = appFlow
        self.preferencPage = .one(nickname: nickname)
    }
}
