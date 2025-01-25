//
//  PreferenceViewModel.swift
//  Catchy
//
//  Created by 정의찬 on 1/23/25.
//

import Foundation

class PreferenceViewModel: ObservableObject {
    
    @Published var preferenceStep: Int = 1
    
    @Published var pageCount: Int = 0
    @Published var bigCategoryBtn: [CategoryType] = []
    @Published var smallCategoryBtn: [CategoryType: [String]] = [:]
    
    func getSmallCategory(category: CategoryType) -> [String] {
        return category.subcategories
    }
}
