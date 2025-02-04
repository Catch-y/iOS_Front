//
//  ReviewReportViewModel.swift
//  Catchy
//
//  Created by 권용빈 on 1/27/25.
//

import Foundation
import Combine

class ReviewReportViewModel: ObservableObject {
    
    @Published var reviewReportData: ReviewReportResponse?
    @Published var isLoading: Bool = false
    @Published var selectedReasons: [ReviewReportReason] = []
    @Published var customReasonText: String = ""
    
    let container: DIContainer
    var cancellables = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
}

extension ReviewReportViewModel {
    func postReviewReportInfo(reviewReportRequest: PostReviewReportRequest) {
        isLoading = true
        
        container.useCaseProvider.reviewReportUseCase.executePostReviewReportInfo(reviewReportRequest: reviewReportRequest)
            .tryMap { responseData -> ResponseData<ReviewReportResponse> in
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
                    print("✅ Post ReviewReportInfo Server Completed")
                case .failure(let failure):
                    print("❌ Post ReviewReportInfo Failed: \(failure)")
                }
                
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                if let response = response.result {
                    print("🎯 Parsed Response Data: \(response)")
                    self.reviewReportData = response
                }
            })
            .store(in: &cancellables)
        
    }
}
