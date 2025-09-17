//
//  PlaceUseCaseProtocol.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/17/25.
//

import Foundation
import Moya
import Combine

protocol PlaceUseCaseProtocol {
    /// 장소 평점/리뷰 달기
    func executePostReview(path: PlaceReviewPath, place: PlaceReviewRequest) -> AnyPublisher<ResponseData<PlaceReviewResponse>, MoyaError>
    /// 장소 좋아요
    func executePathLike(path: PlaceLikePath) -> AnyPublisher<ResponseData<PlaceLikeResponse>, MoyaError>
    /// 장소리뷰 전체 조회
    func executeGetPlaceReview(path: PlaceAllReviewPath, query: PlaceAllReviewQuery) -> AnyPublisher<ResponseData<PlaceAllReviewResponse>, MoyaError>
    /// 장소 방문 날짜
    func executeGetPlaceVisit(path: PlaceVisitListPath) -> AnyPublisher<ResponseData<PlaceVisitListResponse>, MoyaError>
    /// 장소 검색
    func executeGetPlaceSearch(query: PlaceSearchQuery) -> AnyPublisher<ResponseData<PlaceSearchResponse>, MoyaError>
    /// 사용자 장소 추천
    func executeGetPlaceRecommend(query: PlaceRecommendQuery) -> AnyPublisher<ResponseData<PlaceRecommendResponse>, MoyaError>
}
