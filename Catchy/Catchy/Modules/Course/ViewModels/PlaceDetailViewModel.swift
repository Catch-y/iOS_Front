//
//  PlaceDetailViewModel.swift
//  Catchy
//
//  Created by LEE on 2/14/25.
//

import Foundation
import SwiftUI
import Combine
import CombineMoya

class PlaceDetailViewModel: ObservableObject {
    
    let container: DIContainer
    
    var cancellables = Set<AnyCancellable>()
    
    /// 장소 상세화면에서 보여주는 데이터
    @Published var placeDetailResponse: PlaceDetailResponse?
    
    /// 장소 카테고리 선택 뷰 상태
    @Published var isPresented: Bool = false
    
    @Published var isLoading: Bool = false
    
    init(container: DIContainer) {
        self.container = container
    }
    
    
}

extension PlaceDetailViewModel {
    
    // MARK: - API 요청 함수
    /// 장소 상세화면 API
    func getPlaceDetail(placeId: Int) {
        
        isLoading = true

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
                
                isLoading = false

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
        
    
    func show(){
        isPresented.toggle()
    }
}
