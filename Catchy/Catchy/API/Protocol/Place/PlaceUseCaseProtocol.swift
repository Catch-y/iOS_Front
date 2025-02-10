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
import SwiftUI

protocol PlaceUseCaseProtocol {
    
    /// 장소 평점/리뷰 달기 API
    func executePostPlaceReviewSubmission(placeId: Int, request: PlaceReviewSubmissionRequest, reviewImages: [UIImage]) -> AnyPublisher<ResponseData<PlaceReviewSubmissionResponse>, MoyaError>
    
    /// 장소 좋아요 API
    func executePatchPlaceLiked(placeId: Int) -> AnyPublisher<ResponseData<PlaceLikedResponse>, MoyaError>
    
    /// 장소 방문 날짜 리스트 조회 API
    func executeGetPlaceVisitedDates(placeId: Int) -> AnyPublisher<ResponseData<PlaceVisitedDateResponse>, MoyaError>
}

