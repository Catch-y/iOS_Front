//
//  SearchViewModel.swift
//  Catchy
//
//  Created by euijjang97 on 12/4/25.
//

import Foundation

@Observable
class SearchViewModel {
    var searchText: String = ""
    var recentSearch: [String] = []
    var searchData: [PlaceSearchContent.PlaceInfoResponse] = .init()
    let searchManager: SearchManager = .shared
    
    // MARK:  - Search Logic
    @MainActor
    public func fetchingData() async {
        self.recentSearch = await self.searchManager.load()
    }

    @MainActor
    public func removeWord(_ word: String) async {
        await searchManager.removeWord(word)
        await fetchingData()
    }

    @MainActor
    public func clearAll() async {
        await searchManager.clearAll()
        await fetchingData()
    }

    @MainActor
    public func saveSearch() async {
        await searchManager.save(searchText)
        await fetchingData()
    }
}
