//
//  PlaceUseCase.swift
//  Catchy
//
//  Created by 권용빈 on 2/1/25.
//

import Foundation
import Combine
import CombineMoya
import Moya
import SwiftUI

class PlaceUseCase: PlaceUseCaseProtocol {

    let repository: PlaceRepositoryProtocol
    
    init(repository: PlaceRepositoryProtocol = PlaceRepository()) {
        self.repository = repository
    }
    
    /// 장소 평점/리뷰 달기 API
    func executePostPlaceReviewSubmission(request: PlaceReviewSubmissionRequest, reviewImages: [UIImage]) -> AnyPublisher<ResponseData<PlaceReviewSubmissionResponse>, Moya.MoyaError> {
        return repository.postPlaceReviewSubmissionData(request: request, reviewImages: reviewImages)
    }
    
    /// 장소 좋아요 API
    func executePatchPlaceLiked(placeId: Int) -> AnyPublisher<ResponseData<PlaceLikedResponse>, Moya.MoyaError> {
        return repository.patchPlaceLikedData(placeId: placeId)
    }
    
    /// 장소 방문 날짜 리스트 조회 API
    func executeGetPlaceVisitedDates(placeId: Int) -> AnyPublisher<ResponseData<PlaceVisitedDateResponse>, MoyaError> {
        return repository.getPlaceVisitedDatesData(placeId: placeId)
    }
    
    
}
