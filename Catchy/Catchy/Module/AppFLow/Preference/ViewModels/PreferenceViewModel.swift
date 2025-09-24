//
//  PreferenceViewModel.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/19/25.
//

import Foundation

@Observable
class PreferenceViewModel {
    // MARK: - StateProperty
    var isExpand: [Int: Bool] = [0: false, 1: false]
    
    // MARK: - Property
    let nickname: String = UserDefaults.standard.string(forKey: AppStorageKey.userNickname) ?? "정보 없음"
    var preferencPage: PageType
    
    // MARK: - First
    var bigCategoryBtn: [CategoryType] = [.BAR, .EXPERIENCE, .RESTAURANT]
    
    // MARK: - Second
    var smallCategoryBtn: [CategoryType: [String]] = [:]
    var categoryPage: Int = 0
    
    // MARK: - Third
    var selectedCompanion: [CompanionType] = .init()
    var selectedWeekDay: [ActiveDate] = .init()
    var leftSelectedTime: Date?
    var rightSelectedTime: Date?
    
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
