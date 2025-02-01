//
//  PlaceService.swift
//  Catchy
//
//  Created by 권용빈 on 2/1/25.
//

import Foundation
import Moya
import Combine
import CombineMoya

class PlaceService: PlaceServiceProtocol {
    
    let provider: MoyaProvider<PlaceAPITarget>
    
    init(provider: MoyaProvider<PlaceAPITarget> = APIManager.shared.testProvider(for: PlaceAPITarget.self)) {
        self.provider = provider
    }
    
    /// 장소 평점/리뷰 달기 API
    func postPlaceReviewSubmission(request: PlaceReviewSubmissionRequest) -> AnyPublisher<ResponseData<PlaceReviewSubmissionResponse>, Moya.MoyaError> {
        return provider.requestPublisher(.postPlaceReviewSubmission(request: request))
            .map(ResponseData<PlaceReviewSubmissionResponse>.self)
            .eraseToAnyPublisher()
    }
    
    /// 장소 좋아요 API
    func patchPlaceLiked(placeId: Int) -> AnyPublisher<ResponseData<PlaceLikedResponse>, Moya.MoyaError> {
        return provider.requestPublisher(.patchPlaceLiked(placeId: placeId))
            .map(ResponseData<PlaceLikedResponse>.self)
            .eraseToAnyPublisher()
    }
}
