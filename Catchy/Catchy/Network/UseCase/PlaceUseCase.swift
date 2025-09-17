//
//  PlaceUseCase.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/17/25.
//

import Foundation
import Moya
import Combine

class PlaceUseCase: PlaceUseCaseProtocol {
    private let service: PlaceServiceProtocol
    
    init(service: PlaceServiceProtocol = PlaceService()) {
        self.service = service
    }
    
    /// 장소 평점/리뷰 달기
    func executePostReview(path: PlaceReviewPath, place: PlaceReviewRequest) -> AnyPublisher<ResponseData<PlaceReviewResponse>, Moya.MoyaError> {
        service.postReview(path: path, place: place)
    }
    
    /// 장소 좋아요
    func executePathLike(path: PlaceLikePath) -> AnyPublisher<ResponseData<PlaceLikeResponse>, Moya.MoyaError> {
        service.pathLike(path: path)
    }
    
    /// 장소리뷰 전체 조회
    func executeGetPlaceReview(path: PlaceAllReviewPath, query: PlaceAllReviewQuery) -> AnyPublisher<ResponseData<PlaceAllReviewResponse>, Moya.MoyaError> {
        service.getPlaceReview(path: path, query: query)
    }
    
    /// 장소 방문 날짜
    func executeGetPlaceVisit(path: PlaceVisitListPath) -> AnyPublisher<ResponseData<PlaceVisitListResponse>, Moya.MoyaError> {
        service.getPlaceVisit(path: path)
    }
    
    /// 장소 검색
    func executeGetPlaceSearch(query: PlaceSearchQuery) -> AnyPublisher<ResponseData<PlaceSearchResponse>, Moya.MoyaError> {
        service.getPlaceSearch(query: query)
    }
    
    /// 사용자 장소 추천
    func executeGetPlaceRecommend(query: PlaceRecommendQuery) -> AnyPublisher<ResponseData<PlaceRecommendResponse>, Moya.MoyaError> {
        service.getPlaceRecommend(query: query)
    }
}
