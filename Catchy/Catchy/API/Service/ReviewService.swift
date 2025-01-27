//
//  ReviewService.swift
//  Catchy
//
//  Created by 권용빈 on 1/26/25.
//

import Foundation
import Moya
import Combine
import CombineMoya

class ReviewService: ReviewServiceProtocol {
    
    let provider: MoyaProvider<ReviewAPITarget>
    
    init(provider: MoyaProvider<ReviewAPITarget> = APIManager.shared.testProvider(for: ReviewAPITarget.self)) {
        self.provider = provider
    }
    
    func getReviewInfo(reviewData: GetReviewRequest) -> AnyPublisher<ResponseData<ReviewResponse>, Moya.MoyaError> {
        return provider.requestPublisher(.getReviewInfo(placeId: reviewData.placeId, page: reviewData.page))
            .map(ResponseData<ReviewResponse>.self)
            .eraseToAnyPublisher()
    }
}
