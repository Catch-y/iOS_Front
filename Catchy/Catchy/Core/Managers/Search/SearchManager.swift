//
//  SaerchManager.swift
//  Catchy
//
//  Created by euijjang97 on 12/5/25.
//

import Foundation

actor SearchManager {
    static let shared = SearchManager()

    private let key = "recentSearch"
    private let userDefaults = UserDefaults.standard

    private init() {}

    func load() -> [String] {
        return userDefaults.stringArray(forKey: key) ?? []
    }

    func save(_ keyword: String) {
        guard !keyword.isEmpty else { return }
        var recentWord: [String] = load()
        if !recentWord.contains(keyword) {
            recentWord.insert(keyword, at: 0)
            if recentWord.count > 14 {
                recentWord.removeLast()
            }
        }
        userDefaults.set(recentWord, forKey: key)
    }

    func clearAll() {
        userDefaults.removeObject(forKey: key)
    }

    func removeWord(_ word: String) {
        var recentWord = load()
        recentWord.removeAll(where: { $0 == word })
        userDefaults.set(recentWord, forKey: key)
    }
}
