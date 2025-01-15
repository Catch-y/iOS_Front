//
//  SearchViewModel.swift
//  Catchy
//
//  Created by 정의찬 on 1/15/25.
//

import Foundation

class SearchViewModel: ObservableObject {
    
    @Published var recentWords: [String] = UserDefaults.standard.stringArray(forKey: "searchKeyword") ?? ["카페", "검색어 예시", "최대 글자수 이정도", "양식", "인도네시아"]
    @Published var searchKeyword: String = ""
    @Published var searchResult: SearchPlaceResponse?
    @Published var searchLoad: Bool = false
    
    let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
    
    public func saveKeyword(_ keyword: String) {
        guard !keyword.isEmpty else { return }
        
        if !self.recentWords.contains(keyword) {
            self.recentWords.insert(keyword, at: 0)
            if self.recentWords.count > 10 {
                self.recentWords.removeLast()
            }
        }
        
        UserDefaults.standard.set(self.recentWords, forKey: "searchKeyword")
    }
}
