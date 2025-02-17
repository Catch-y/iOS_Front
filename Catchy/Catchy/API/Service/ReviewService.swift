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
    
    func getPlaceReviewInfo(placeId: Int, request: PlaceReviewRequest) -> AnyPublisher<ResponseData<PlaceReviewInfoResponse>, Moya.MoyaError> {
        return provider.requestPublisher(.getPlaceReviewInfo(placeId: placeId, request: request))
            .map(ResponseData<PlaceReviewInfoResponse>.self)
            .eraseToAnyPublisher()
    }
    
    func getCourseReviewInfo(courseId: Int, pageSize: Int, lastReviewId: Int?) -> AnyPublisher<ResponseData<CourseReviewInfoResponse>, Moya.MoyaError> {
        return provider.requestPublisher(.getCourseReviewInfo(courseId: courseId, pageSize: pageSize, lastReviewId: lastReviewId))
            .map(ResponseData<CourseReviewInfoResponse>.self)
            .eraseToAnyPublisher()
    }
    
}
