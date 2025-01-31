//
//  PreferenceViewModel.swift
//  Catchy
//
//  Created by 정의찬 on 1/23/25.
//

import Foundation

class PreferenceViewModel: ObservableObject {
    
    let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
    
    //MARK: - 전체 스텝 관리
    @Published var preferenceStep: Int = 2
    
    //MARK: - 1번째, 2번째 스텝 관리
    @Published var pageCount: Int = 0
    
    /* Request 저장 */
    @Published var bigCategoryBtn: [CategoryType] = [.BAR, .CAFE]
    @Published var smallCategoryBtn: [CategoryType: [String]] = [:]
    
    func getSmallCategory(category: CategoryType) -> [String] {
        return category.subcategories
    }
    
    //MARK: - 3번째, 4번째 스텝 관리
    /// RequestData
    @Published var stepThirdData: StepThirdRequest?
    
    @Published var selectedCompanion: [CompanionType] = []
    @Published var selectedWeekDay: [ActiveDate] = []
    @Published var startTime: String = ""
    @Published var endTime: String = ""
    
    @Published var leftSelectedTime: Date? = nil
    @Published var rightSelectedTime: Date? = nil
    
    @Published var isExpand: [Int:Bool] = [0: false, 1: false]
}
