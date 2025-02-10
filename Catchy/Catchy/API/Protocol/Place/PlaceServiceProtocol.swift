//
//  PlaceServiceProtocol.swift
//  Catchy
//
//  Created by 권용빈 on 2/1/25.
//

import Foundation
import CombineMoya
import Combine
import Moya
import SwiftUI

protocol PlaceServiceProtocol {
    
    /// 장소 평점/리뷰 달기 API
    func postPlaceReviewSubmission(placeId: Int, request: PlaceReviewSubmissionRequest, reviewImages: [UIImage]) -> AnyPublisher<ResponseData<PlaceReviewSubmissionResponse>, MoyaError>
    
    /// 장소 좋아요 API
    func patchPlaceLiked(placeId: Int) -> AnyPublisher<ResponseData<PlaceLikedResponse>, MoyaError>
    
    /// 장소 방문 날짜 리스트 조회 API
    func getPlaceVisitedDates(placeId: Int) -> AnyPublisher<ResponseData<PlaceVisitedDateResponse>, MoyaError>
}
