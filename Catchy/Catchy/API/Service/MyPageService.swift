//
//  MyPageService.swift
//  Catchy
//
//  Created by 권용빈 on 2/2/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// 마이페이지 Service
class MyPageService: MyPageServiceProtocol {
    
    let provider: MoyaProvider<MyPageAPITarget>
    
    init(provider: MoyaProvider<MyPageAPITarget> = APIManager.shared.testProvider(for: MyPageAPITarget.self)){
        self.provider = provider
    }
    
    /// 프로필 조회
    func getProfile() -> AnyPublisher<ResponseData<ProfileResponse>, MoyaError> {
        return provider.requestPublisher(.getProfile)
            .map(ResponseData<ProfileResponse>.self)
            .eraseToAnyPublisher()
    }
    
    /// 북마크된 코스 무한 스크롤 API
    func getBookmarkCourseList(pageSize: Int, lastCourseId: Int? = nil) -> AnyPublisher<ResponseData<CourseResponse>, Moya.MoyaError> {
        return provider.requestPublisher(.getBookmarkCourseList(pageSize: pageSize, lastCourseId: lastCourseId))
            .map(ResponseData<CourseResponse>.self)
            .eraseToAnyPublisher()
    }
    
    /// 내 코스 리뷰 조회 API
    func getMyCourseReviews(review: MyCourseReviewRequest) -> AnyPublisher<ResponseData<MyCourseReviewResponse>, Moya.MoyaError> {
        return provider.requestPublisher(.getMyCourseReviews(review: review))
            .map(ResponseData<MyCourseReviewResponse>.self)
            .eraseToAnyPublisher()
    }
    
    /// 내 장소 리뷰 조회 API
    func getMyPlaceReviews(review: MyPlaceReviewRequest) -> AnyPublisher<ResponseData<MyPlaceReviewResponse>, Moya.MoyaError> {
        return provider.requestPublisher(.getMyPlaceReviews(review: review))
            .map(ResponseData<MyPlaceReviewResponse>.self)
            .eraseToAnyPublisher()
    }
    
    /// 리뷰 삭제 API
    func deleteReview(reviewId: Int, reviewType: ReviewType) -> AnyPublisher<ResponseData<DeleteReviewResponse>, Moya.MoyaError> {
        return provider.requestPublisher(.deleteReview(reviewId: reviewId, reviewType: reviewType))
            .map(ResponseData<DeleteReviewResponse>.self)
            .eraseToAnyPublisher()
    }
}
