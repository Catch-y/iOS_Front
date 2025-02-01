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

class PlaceRepository: PlaceRepositoryProtocol {

    let service: PlaceServiceProtocol
    
    init(service: PlaceServiceProtocol = PlaceService()) {
        self.service = service
    }
    
    /// 장소 평점/리뷰 달기 API
    func postPlaceReviewSubmissionData(request: PlaceReviewSubmissionRequest) -> AnyPublisher<ResponseData<PlaceReviewSubmissionResponse>, Moya.MoyaError> {
        return service.postPlaceReviewSubmission(request: request)
    }
    
    /// 장소 좋아요 API
    func patchPlaceLikedData(placeId: Int) -> AnyPublisher<ResponseData<PlaceLikedResponse>, Moya.MoyaError> {
        return service.patchPlaceLiked(placeId: placeId)
    }
    
}
