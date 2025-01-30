//
//  PlaceSearchViewModel.swift
//  Catchy
//
//  Created by LEE on 1/27/25.
//

import Foundation
import SwiftUI
import Combine

class PlaceSearchViewModel: ObservableObject {
    
    let container: DIContainer
    
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - Place Search View Properties
    
    /// 장소 검색 결과
    @Published var placeSearchResponse: PlaceSearchResponse?
    
    /// 장소 상세 정보
    @Published var placeDetailResponse: PlaceDetailResponse?
    
    /// 현재 담은 장소 리스트
    @Published var placeList: [PlaceDetailResponse]?
    
    /// 검색어
    @Published var searchText: String = ""
    
    /// 장소 목록 - API 통신 중인가?
    @Published var isPlaceListLoading: Bool = false
    
    /// 장소 상세 정보 -  API 통신 중인가?
    @Published var isPlaceDetailLoading: Bool = false
    
    /// 현재 코스에 담은 장소들의 ID 리스트
    /// placeId가 있음.
    @Published var places: [Int] = []
    
    init(container: DIContainer){
        self.container = container
    }
    
}

extension PlaceSearchViewModel {
    
    // MARK: - API 호출 함수
    /// 장소 검색 - 지역명 기반
    func getPlaceList(placeSearchRequest: PlaceSearchRequest) {
        
        isPlaceListLoading = true
        
        container.useCaseProvider.courseManagementUseCase.executeGetPlaceList(placeSearchRequest: placeSearchRequest)
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
                    
                switch completion {
                case .finished:
                    print("✅ Get PlaceSearchList Server Completed")
                case .failure(let failure):
                    print("❌ Get PlaceSearchList Failed: \(failure)")
                }
            },receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                if let response = response.result{
                    self.placeSearchResponse = response
                }
                
            })
            .store(in: &cancellables)
    }
    
    /// 장소 검색 - 상세 화면
    func getPlaceDetail(placeId: Int) async {
        
        isPlaceDetailLoading = true
        
        container.useCaseProvider.courseManagementUseCase.executeGetPlaceDetail(placeId: placeId)
            .tryMap {
                responseData ->
                ResponseData<PlaceDetailResponse> in
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

                isPlaceDetailLoading = true
                
                switch completion {
                case .finished:
                    print("✅ Get PlaceDetail Server Completed")
                case .failure(let failure):
                    print("❌ Get PlaceDetail Failed: \(failure)")
                }
            },receiveValue: { [weak self] response in
                print("zz")
                guard let self = self else { return }
                print("zzz")
                if let response = response.result {
                    self.placeDetailResponse = response
                }
                print("zzzzz")
            })
            .store(in: &cancellables)
    }
    
    
    
}
