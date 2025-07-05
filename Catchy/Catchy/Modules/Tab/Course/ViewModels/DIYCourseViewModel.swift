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
    @Published var searchText: String = "" {
        didSet {
            isLast = false
            page = 1
        }
    }
    
    /// 장소 목록 - API 통신 중인가?
    @Published var isPlaceListLoading: Bool = false
    
    // MARK: - 장소 상세 화면 Properties
    /// 장소 상세 화면 결과
    @Published var placeDetailResponse: PlaceDetailResponse?
    
    /// 장소 상세 화면 로딩중인가?
    @Published var isPlaceDetailLoading: Bool = false
    
    /// 카테고리 등록 화면 상태
    @Published var isCategoryViewPresented: Bool = false
    
    /// 현재 요청한 페이지
    var page: Int = 1
    
    /// 마지막 요청인가?
    var isLast: Bool = false
    
    /// 무한 스크롤 요청 중인가?
    var isPrefetching: Bool = false
    
    /// 네비게이션 POP인경우 장소 검색 리스트 요청 X
    var onAppearByPop: Bool = false
    
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
        guard !isLast, !isPlaceListLoading else { return }
        
        if onAppearByPop {
            onAppearByPop = false
            return
        }
        
        if !isPrefetching {
            isPlaceListLoading = true
        }
        
        self.isPlaceListLoading = true

        // 현재 위치 가져오기
////        BaseLocationManager.shared.getCurrentUserLocation { [weak self] userLocation in
//            guard let self = self, let location = userLocation else {
//                print("❌ 현재 위치를 가져올 수 없습니다.")
//                self?.isPlaceListLoading = false
//                return
//            }
            
        let latitude = 1.1
        let longitude = 1.1
            
            // 검색 요청 실행
            let request = PlaceSearchByRegionRequest(searchKeyword: searchText, latitude: latitude, longitude: longitude, page: page)
            
            container.useCaseProvider.placeCourseUseCase.executeGetPlaceListByRegion(placeSearchRequest: request)
                .tryMap { responseData -> ResponseData<PlaceSearchResponse> in
                    if !responseData.isSuccess {
                        throw APIError.serverError(message: responseData.message, code: responseData.code)
                    }
                    return responseData
                }
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] completion in
                    guard let self = self else { return }
                    
                    self.isPlaceListLoading = false
                    
                    switch completion {
                    case .finished:
                        print("✅ Get PlaceSearchList Server Completed")
                    case .failure(let failure):
                        print("❌ Get PlaceSearchList Failed: \(failure)")
                    }
                }, receiveValue: { [weak self] response in
                    guard let self = self else { return }
                    
                    if let response = response.result {
                        if placeSearchResponse == nil {
                            placeList = response.placeInfoPreviews
                        } else {
                            if isPrefetching {
                                self.placeList.append(contentsOf: response.placeInfoPreviews)
                                isPrefetching = false
                            } else {
                                self.placeList = response.placeInfoPreviews
                            }
                        }
                        isPrefetching = false
                        self.placeSearchResponse = response
                        self.isLast = response.isLast
                        self.page += 1
                    }
                })
                .store(in: &cancellables)
//        }
    }
    
    /// 장소 상세 화면 API
    func getPlaceDetail(placeId: Int) {
        
        self.isPlaceDetailLoading = true

        container.useCaseProvider.placeCourseUseCase.executeGetPlaceDetail(placeId: placeId)
            .tryMap {
                responseData ->
                ResponseData<PlaceDetailResponse> in
                if !responseData.isSuccess {
                    throw APIError
                        .serverError(
                            message: responseData.message,
                            code: responseData.code
                        )
                }

                return responseData
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                [weak self] completion in
                guard let self = self else { return }
                
                self.isPlaceDetailLoading = false

                switch completion {
                case .finished:
                    print("✅ Get PlaceDetail Server Completed")
                case .failure(let failure):
                    print("❌ Get PlaceDetail Failed: \(failure)")
                }
            },receiveValue: { [weak self] response in
                guard let self = self else { return }
                if let response = response.result {
                    self.placeDetailResponse = response
                }
            })
            .store(in: &cancellables)
    }
    
    // TODO: - 현재 위치 기반 장소 검색 API 구현
    
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
    
    func showCategoryView(){
        self.isCategoryViewPresented.toggle()
    }
        
}
