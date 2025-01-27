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
    
    @Published var searchText: String = ""
    
    @Published var isLoading: Bool = false
    
    init(container: DIContainer){
        self.container = container
    }
    
}

extension PlaceSearchViewModel {
    
    // MARK: - API 호출 함수
    /// 장소 검색 - 지역명 기반
    func getPlaceList(placeSearchRequest: PlaceSearchRequest) {
        
        isLoading = true
        
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
                self.isLoading = false
                    
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
}
