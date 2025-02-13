//
//  SearchViewModel.swift
//  Catchy
//
//  Created by 정의찬 on 1/15/25.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    
    @Published var recentWords: [String] = UserDefaults.standard.stringArray(forKey: "searchKeyword") ?? ["카페", "검색어 예시", "최대 글자수 이정도", "양식", "인도네시아"]
    @Published var searchKeyword: String = ""
    @Published var searchResult: SearchPlaceResponse?
    @Published var searchLoad: Bool = false
    @Published var showResult: Bool = false
    
    var currentPage: Int = 1
    var isLast: Bool = false
    
    let container: DIContainer
    private var cancellables = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
        realTimeSearch()
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
    
    private func realTimeSearch() {
        $searchKeyword
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .filter { !$0.isEmpty }
            .sink { [weak self] keyword in
                guard let self = self else { return }
                print("🔄 realTimeSearch triggered: \(keyword)")
                self.performSearch(for: keyword)
            }
            .store(in: &cancellables)
    }
    
    public func performSearch(for keyword: String) {
        guard !searchLoad, !isLast else {
            print("한 번 더 호출 막힘")
            return
        }
        
        searchLoad = true
        
        container.useCaseProvider.homeUseCase.executeGetSearch(keyword: keyword, page: currentPage)
            .tryMap { responseData -> ResponseData<SearchPlaceResponse> in
                if !responseData.isSuccess {
                    throw APIError.serverError(message: responseData.message, code: responseData.code)
                }
                
                guard let _ = responseData.result else {
                    throw APIError.emptyResult
                }
                
                print("Get Search Server: \(responseData)")
                return responseData
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                
                searchLoad = false
                showResult = true
                
                switch completion {
                case .finished:
                    print("✅ Search request completed")
                case .failure(let failure):
                    print("❌ Search request failed: \(failure)")
                    searchResult = nil
                }
            }, receiveValue:{ [weak self] response in
                guard let self = self else { return }
                if let newData = response.result {
                    if newData.placeInfoPreviews.isEmpty {
                        searchResult = nil
                    } else {
                        if searchResult == nil {
                            searchResult = newData
                        } else {
                            searchResult?.placeInfoPreviews.append(contentsOf: newData.placeInfoPreviews)
                        }
                        isLast = newData.isLast
                        if !isLast {
                            currentPage += 1
                        }
                    }
                }
                print("🔍 Search results updated: \(String(describing: response.result))")
            })
            .store(in: &cancellables)
    }
}
