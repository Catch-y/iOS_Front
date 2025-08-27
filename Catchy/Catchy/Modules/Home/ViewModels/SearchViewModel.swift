//
//  SearchViewModel.swift
//  Catchy
//
//  Created by 정의찬 on 1/15/25.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    
    @Published var recentWords: [String] = UserDefaults.standard.stringArray(forKey: "searchKeyword") ?? []
    @Published var searchKeyword: String = ""
    @Published var searchResult: SearchPlaceResponse?
    @Published var flatSearchData: [SearchPlaceData] = []  // 평탄화된 검색 결과 배열 추가
    @Published var searchLoad: Bool = false
    @Published var showResult: Bool = false
    
    private var lastPlaceId: Int? = nil
    private var relevanceScore: Int? = nil
    
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
        if !recentWords.contains(keyword) {
            recentWords.insert(keyword, at: 0)
            if recentWords.count > 10 {
                recentWords.removeLast()
            }
        }
        UserDefaults.standard.set(recentWords, forKey: "searchKeyword")
    }
    
    private func realTimeSearch() {
        $searchKeyword
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] keyword in
                guard let self = self else { return }
                print("🔄 realTimeSearch triggered: \(keyword)")
                if keyword.isEmpty {
                    self.searchResult = nil
                    self.flatSearchData = []
                    self.isLast = false
                    self.currentPage = 1
                    return
                }
                self.performSearch(for: keyword)
            }
            .store(in: &cancellables)
    }
    
    public func performSearch(for keyword: String) {
        // 무한 스크롤 조건: 로딩 중이 아니고, 마지막 페이지가 아니어야 함.
        guard !searchLoad, !isLast else { return }
        searchLoad = true
        
        container.useCaseProvider.homeUseCase.executeGetSearch(
            keyword: keyword,
            page: 10, // API 호출 시 고정값 10 사용
            relevanceScore: relevanceScore,
            lastPlaceId: lastPlaceId
        )
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
            self.searchLoad = false
            self.showResult = true
            switch completion {
            case .finished:
                print("✅ Search request completed")
            case .failure(let failure):
                print("❌ Search request failed: \(failure)")
                self.searchResult = nil
                self.flatSearchData = []
            }
        }, receiveValue: { [weak self] response in
            guard let self = self, let newData = response.result else { return }
            // newData.placeInfoPreviews는 [PlaceInfoDataAndScore] 배열입니다.
            // 평탄화: 각 preview의 placeInfoResponse를 단일 배열로 만듦.
            let newFlatData = newData.placeInfoPreviews.compactMap { $0.placeInfoResponse }
            
            if newFlatData.isEmpty {
                self.searchResult = nil
                self.flatSearchData = []
            } else {
                if self.currentPage == 1 {
                    self.flatSearchData = newFlatData
                    self.searchResult = newData
                } else {
                    self.flatSearchData.append(contentsOf: newFlatData)
                    self.searchResult?.placeInfoPreviews.append(contentsOf: newData.placeInfoPreviews)
                }
                
                // 마지막 요소 업데이트: 평탄화된 배열에서 마지막 요소의 placeId 사용
                if let lastPlace = newFlatData.last {
                    self.lastPlaceId = lastPlace.placeId
                }
                // relevanceScore는 마지막 preview에서 가져옴
                if let lastPreview = newData.placeInfoPreviews.last {
                    self.relevanceScore = lastPreview.relevanceScore
                }
                self.isLast = newData.isLast
                if !self.isLast {
                    self.currentPage += 1
                }
            }
            print("🔍 Search results updated: \(self.flatSearchData.count) items")
        })
        .store(in: &cancellables)
    }
    
    /// 리프레시: 검색 결과를 초기화하고 다시 검색합니다.
    func searchRefresh() async {
        self.isLast = false
        self.currentPage = 1
        do {
            try await Task.sleep(nanoseconds: 1_000_000_000)
            self.searchResult = nil
            self.flatSearchData = []
            performSearch(for: searchKeyword)
        } catch {
            print("❌ Refresh 오류: \(error)")
        }
    }
}
