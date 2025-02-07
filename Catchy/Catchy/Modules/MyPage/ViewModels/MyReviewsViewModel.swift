//
//  MyReviewsViewModel.swift
//  Catchy
//
//  Created by 권용빈 on 2/6/25.
//

import SwiftUI
import Combine

class MyReviewsViewModel: ObservableObject {
    
    @Published var myReviewsData: MyReviewResponse?
    @Published var isLoading: Bool = false  // API 로딩 상태
    
    @Published var selectedSegment: ReviewSegment = .course
    @Published var reviewCount: Int = 0
    
    
    let container: DIContainer
    var cancellables = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
}

extension MyReviewsViewModel {
    func getMyReviews(review: MyReviewRequest){
        isLoading = true
        
        container.useCaseProvider.myPageUseCase.executeGetMyReviews(review: review)
            .tryMap { responseData -> ResponseData<MyReviewResponse> in
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
                    print("✅ Get My Reviews Completed")
                case .failure(let failure):
                    print("❌ Get My Reviews Failed: \(failure)")
                }
                
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                if let response = response.result {
                    print("🎯 Parsed Response Data: \(response)")
                    self.myReviewsData = response
                }
            })
            .store(in: &cancellables)
    }
}
