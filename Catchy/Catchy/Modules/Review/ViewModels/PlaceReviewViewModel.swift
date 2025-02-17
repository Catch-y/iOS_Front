//
//  ReviewsViewModel.swift
//  Catchy
//
//  Created by 권용빈 on 1/22/25.
//

import Foundation
import Combine

class PlaceReviewViewModel: ObservableObject {
    
    @Published var placeReviewData: PlaceReviewInfoResponse?
    @Published var isLoading: Bool = false
    
    let container: DIContainer
    var cancellables = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
}

extension PlaceReviewViewModel {
    func getReviewData(placeId: Int, request: PlaceReviewRequest) {
        isLoading = true
        
        container.useCaseProvider.reviewUseCase.executePlaceReviewResponse(placeId: placeId, request: request)
            .tryMap { responseData -> ResponseData<PlaceReviewInfoResponse> in
                if !responseData.isSuccess {
                    throw APIError.serverError(message: responseData.message, code: responseData.code)
                }
                
                return responseData
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                
                switch completion {
                case .finished:
                    print("✅ Get ReviewInfo Server Completed")
                case .failure(let failure):
                    print("❌ Get ReviewInfo Failed: \(failure)")
                }
                
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                if let response = response.result {
                    print("🎯 Parsed Response Data: \(response)")
                    self.placeReviewData = response
                }
            })
            .store(in: &cancellables)
        
    }
}
