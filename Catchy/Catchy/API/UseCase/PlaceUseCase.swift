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

class PlaceUseCase: PlaceUseCaseProtocol {

    let repository: PlaceRepositoryProtocol
    
    init(repository: PlaceRepositoryProtocol = PlaceRepository()) {
        self.repository = repository
    }
    
    /// 장소 평점/리뷰 달기 API
    func executePostPlaceReviewSubmission(request: PlaceReviewSubmissionRequest) -> AnyPublisher<ResponseData<PlaceReviewSubmissionResponse>, Moya.MoyaError> {
        return repository.postPlaceReviewSubmissionData(request: request)
    }
    
    /// 장소 좋아요 API
    func executePatchPlaceLiked(placeId: Int) -> AnyPublisher<ResponseData<PlaceLikedResponse>, Moya.MoyaError> {
        return repository.patchPlaceLikedData(placeId: placeId)
    }
    
    
}
