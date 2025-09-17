//
//  PlaceServiceProtocol.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/17/25.
//

import Foundation
import Moya
import Combine

protocol PlaceServiceProtocol {
    /// 장소 평점/리뷰 달기
    func postReview(path: PlaceReviewPath, place: PlaceReviewRequest) -> AnyPublisher<ResponseData<PlaceReviewResponse>, MoyaError>
    /// 장소 좋아요
    func pathLike(path: PlaceLikePath) -> AnyPublisher<ResponseData<PlaceLikeResponse>, MoyaError>
    /// 장소리뷰 전체 조회
    func getPlaceReview(path: PlaceAllReviewPath, query: PlaceAllReviewQuery) -> AnyPublisher<ResponseData<PlaceAllReviewResponse>, MoyaError>
    /// 장소 방문 날짜
    func getPlaceVisit(path: PlaceVisitListPath) -> AnyPublisher<ResponseData<PlaceVisitListResponse>, MoyaError>
    /// 장소 검색
    func getPlaceSearch(query: PlaceSearchQuery) -> AnyPublisher<ResponseData<PlaceSearchResponse>, MoyaError>
    /// 사용자 장소 추천
    func getPlaceRecommend(query: PlaceRecommendQuery) -> AnyPublisher<ResponseData<PlaceRecommendResponse>, MoyaError>
}
