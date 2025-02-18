//
//  DIYCourseViewModel.swift
//  Catchy
//
//  Created by LEE on 1/27/25.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class DIYCourseViewModel: ObservableObject {
        
    let container: DIContainer
    
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - 장소 검색 화면 Properties (코스 DIY)
    /// 장소 검색 결과
    @Published var placeSearchResponse: PlaceSearchResponse?
        
    /// 현재 담은 장소 리스트
    @Published var selectedPlaceList: [PlaceSearchResponseData] = []
    
    /// 스크롤 뷰에서 보여주는 장소
    @Published var placeList: [PlaceSearchResponseData] = []
    
    /// 검색어
    @Published var searchText: String = ""
    
    /// 장소 목록 - API 통신 중인가?
    @Published var isPlaceListLoading: Bool = false
    
    /// 현재 요청한 페이지
    var page: Int = 1
    
    /// 마지막 요청인가?
    var isLast: Bool = false
    
    /// 무한 스크롤 요청 중인가?
    var isPrefetching: Bool = false
        
    // MARK: - 장소 리뷰 화면 Properties
    /// 장소 리뷰 화면 상태
    @Published var isReviewPresented: Bool = false
    
    /// 평점, 리뷰를 보고자하는 장소 ID
    var selectedPlaceId: Int? = nil
    
    // MARK: - Init
    init(container: DIContainer){
        self.container = container
    }
    
}

// MARK: - Extension
extension DIYCourseViewModel {
    
    // MARK: - API 호출 함수
    /// 장소 검색 - 지역명 기반
    func getPlaceListByRegion() {
        
        guard !isLast else { return }
        
        if !isPrefetching {
            isPlaceListLoading = true
        }
        
        
        let request = PlaceSearchByRegionRequest(searchKeyword: searchText, page: page)
        container.useCaseProvider.placeCourseUseCase.executeGetPlaceListByRegion(placeSearchRequest: request)
            .tryMap {
                responseData ->
                ResponseData<PlaceSearchResponse> in
                if !responseData.isSuccess {
                    throw APIError
                        .serverError(message: responseData.message,
                            code: responseData.code
                        )
                }
                
                return responseData
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                [weak self] completion in
                guard let self = self else { return }
                
                self.isPlaceListLoading = false
                self.isPrefetching = false
                
                switch completion {
                case .finished:
                    print("✅ Get PlaceSearchList Server Completed")
                case .failure(let failure):
                    print("❌ Get PlaceSearchList Failed: \(failure)")
                }
            },receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                if let response = response.result {
                    
                    if placeSearchResponse == nil {
                        placeList = response.placeInfoPreviews
                    } else {
                        self.placeList.append(contentsOf: response.placeInfoPreviews)
                    }
                    self.placeSearchResponse = response
                    self.isLast = response.isLast
                    self.page += 1

                }
                
            })
            .store(in: &cancellables)
    }
    
    // MARK: - API 호출 없는 함수
    /// 리프레시 함수
    func refresh() async {
        self.isLast = false
        self.page = 1 
        
        do {
            try await Task.sleep(nanoseconds: 1_500_000_000)
            self.placeSearchResponse = nil
            self.getPlaceListByRegion()
        } catch {
            print("❌ Refresh 오류: \(error)")
        }
                
    }
    
    /// 장소 리뷰뷰를 보여줍니다
    /// - Parameter placeId: 리뷰, 평점을 보고자 하는 장소 ID
    func showReview(placeId: Int) {
        self.selectedPlaceId = placeId
        self.isReviewPresented.toggle()
    }
    
}
