//
//  PlaceDetailViewModel.swift
//  Catchy
//
//  Created by LEE on 1/28/25.
//

import Foundation
import SwiftUI
import Combine

class PlaceDetailViewModel: ObservableObject {
    
    let container: DIContainer
    
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - Place Detail View Properties
    /// 장소 상세 정보
    @Published var placeDetailResponse: PlaceDetailResponse?
    
    /// API 통신 중인가?
    @Published var isLoading: Bool = false
    
    /// 해당 장소를 현재 코스에 담았는가?
    @Published var isIncluded: Bool = false
    
    init(container: DIContainer) {
        self.container = container
    }
    
}

extension PlaceDetailViewModel {
    
    // MARK: - API 호출 함수
    /// 장소 검색 - 상세 화면
    func getPlaceDetail(placeDetailRequest: PlaceDetailRequest){
        
        isLoading = true
        
        container.useCaseProvider.courseManagementUseCase.executeGetPlaceDetail(placeDetailRequest: placeDetailRequest)
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
                self.isLoading = false
                    
                switch completion {
                case .finished:
                    print("✅ Get PlaceDetail Server Completed")
                case .failure(let failure):
                    print("❌ Get PlaceDetail Failed: \(failure)")
                }
            },receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                if let response = response.result{
                    self.placeDetailResponse = response
                }
                
            })
            .store(in: &cancellables)
        
        
    }
}
