//
//  PlaceUseCaseProtocol.swift
//  Catchy
//
//  Created by 권용빈 on 2/1/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

protocol PlaceUseCaseProtocol {
    
    /// 장소 평점/리뷰 달기 API
    func executePostPlaceReviewSubmission(request: PlaceReviewSubmissionRequest) -> AnyPublisher<ResponseData<PlaceReviewSubmissionResponse>, MoyaError>
    
    /// 장소 좋아요 API
    func executePatchPlaceLiked(placeId: Int) -> AnyPublisher<ResponseData<PlaceLikedResponse>, MoyaError>
}

