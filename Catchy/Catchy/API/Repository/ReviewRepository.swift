//
//  ReviewRepository.swift
//  Catchy
//
//  Created by 권용빈 on 1/26/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

class ReviewRepository: ReviewRepositoryProtocol {
    let service: ReviewServiceProtocol
    
    init(service: ReviewServiceProtocol = ReviewService()) {
        self.service = service
    }
    
    func getReviewInfoData(reviewData: GetReviewRequest) -> AnyPublisher<ResponseData<ReviewResponse>, MoyaError> {
        return service.getReviewInfo(reviewData: reviewData)
    }
}
