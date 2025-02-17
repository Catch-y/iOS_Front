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
    
    func getPlaceReviewInfoData(placeId: Int, request: PlaceReviewRequest) -> AnyPublisher<ResponseData<PlaceReviewInfoResponse>, Moya.MoyaError> {
        return service.getPlaceReviewInfo(placeId: placeId, request: request)
    }
    
    func getCourseReviewInfoData(courseId: Int, pageSize: Int, lastReviewId: Int?) -> AnyPublisher<ResponseData<CourseReviewInfoResponse>, Moya.MoyaError> {
        return service.getCourseReviewInfo(courseId: courseId, pageSize: pageSize, lastReviewId: lastReviewId)
    }
}
