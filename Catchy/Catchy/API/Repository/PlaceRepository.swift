//
//  PlaceRepository.swift
//  Catchy
//
//  Created by 권용빈 on 2/1/25.
//

import Foundation
import Combine
import CombineMoya
import Moya
import SwiftUI

class PlaceRepository: PlaceRepositoryProtocol {

    let service: PlaceServiceProtocol
    
    init(service: PlaceServiceProtocol = PlaceService()) {
        self.service = service
    }
    
    /// 장소 평점/리뷰 달기 API
    func postPlaceReviewSubmissionData(placeId: Int, request: PlaceReviewSubmissionRequest, reviewImages: [UIImage]) -> AnyPublisher<ResponseData<PlaceReviewSubmissionResponse>, Moya.MoyaError> {
        return service.postPlaceReviewSubmission(placeId: placeId, request: request, reviewImages: reviewImages)
    }
    
    /// 장소 좋아요 API
    func patchPlaceLikedData(placeId: Int) -> AnyPublisher<ResponseData<PlaceLikedResponse>, Moya.MoyaError> {
        return service.patchPlaceLiked(placeId: placeId)
    }
    
    /// 장소 방문 날짜 리스트 조회 API
    func getPlaceVisitedDatesData(placeId: Int) -> AnyPublisher<ResponseData<PlaceVisitedDateResponse>, MoyaError> {
        return service.getPlaceVisitedDates(placeId: placeId)
    }
}
