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
import SwiftUI

class PlaceService: PlaceServiceProtocol {
    
    let provider: MoyaProvider<PlaceAPITarget>
    
    init(provider: MoyaProvider<PlaceAPITarget> = APIManager.shared.testProvider(for: PlaceAPITarget.self)) {
        self.provider = provider
    }
    
    /// 장소 평점/리뷰 달기 API
    func postPlaceReviewSubmission(request: PlaceReviewSubmissionRequest, reviewImages: [UIImage]) -> AnyPublisher<ResponseData<PlaceReviewSubmissionResponse>, Moya.MoyaError> {
        return provider.requestPublisher(.postPlaceReviewSubmission(request: request, reviewImages: reviewImages))
            .map(ResponseData<PlaceReviewSubmissionResponse>.self)
            .eraseToAnyPublisher()
    }
    
    /// 장소 좋아요 API
    func patchPlaceLiked(placeId: Int) -> AnyPublisher<ResponseData<PlaceLikedResponse>, Moya.MoyaError> {
        return provider.requestPublisher(.patchPlaceLiked(placeId: placeId))
            .map(ResponseData<PlaceLikedResponse>.self)
            .eraseToAnyPublisher()
    }
    
    /// 장소 방문 날짜 리스트 조회 API
    func getPlaceVisitedDates(placeId: Int) -> AnyPublisher<ResponseData<PlaceVisitedDateResponse>, MoyaError> {
        return provider.requestPublisher(.getVisitedDateList(placeId: placeId))
            .map(ResponseData<PlaceVisitedDateResponse>.self)
            .eraseToAnyPublisher()
    }
}
