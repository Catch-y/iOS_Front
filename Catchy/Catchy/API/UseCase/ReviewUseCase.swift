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

    func executePlaceReviewResponse(placeId: Int, request: PlaceReviewRequest) -> AnyPublisher<ResponseData<PlaceReviewInfoResponse>, Moya.MoyaError> {
        return repository.getPlaceReviewInfoData(placeId: placeId, request: request)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    func executeCourseReviewResponse(courseId: Int, pageSize: Int, lastReviewId: Int?) -> AnyPublisher<ResponseData<CourseReviewInfoResponse>, Moya.MoyaError> {
        return repository.getCourseReviewInfoData(courseId: courseId, pageSize: pageSize, lastReviewId: lastReviewId)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
}
