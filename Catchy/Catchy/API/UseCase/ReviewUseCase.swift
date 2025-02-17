//
//  ReviewUseCase.swift
//  Catchy
//
//  Created by 권용빈 on 1/26/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

class ReviewUseCase: ReviewUseCaseProtocol {
    
    let repository: ReviewRepositoryProtocol
    
    init(repository: ReviewRepositoryProtocol = ReviewRepository()) {
        self.repository = repository
    }
    
    func executeReviewResponse(reviewData: GetReviewRequest) -> AnyPublisher<ResponseData<ReviewResponse>, MoyaError> {
        return repository.getReviewInfoData(reviewData: reviewData)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
}
