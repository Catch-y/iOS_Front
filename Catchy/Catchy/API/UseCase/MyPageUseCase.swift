//
//  MyPageUseCase.swift
//  Catchy
//
//  Created by 권용빈 on 2/2/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [코스 관리] UseCase 객체
class MyPageUseCase: MyPageUseCaseProtocol {
    
    let repository: MyPageRepositoryProtocol
    
    init(repository: MyPageRepositoryProtocol = MyPageRepository()) {
        self.repository = repository
    }
    
    /// 코스 조회
    func executeGetProfile() -> AnyPublisher<ResponseData<ProfileResponse>, Moya.MoyaError> {
        return repository.getProfileData()
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    /// 북마크된 코스 무한 스크롤 API
    func executeGetBookmarkCourseList(pageSize: Int, lastCourseId: Int? = nil) -> AnyPublisher<ResponseData<CourseResponse>, Moya.MoyaError> {
        return repository.getBookmarkCourseListData(pageSize: pageSize, lastCourseId: lastCourseId)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    /// 내 코스 리뷰 조회 API
    func executeGetMyCourseReviews(review: MyCourseReviewRequest) -> AnyPublisher<ResponseData<MyCourseReviewResponse>, Moya.MoyaError> {
        return repository.getMyCourseReviewsData(review: review)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    /// 내 장소 리뷰 조회 API
    func executeGetMyPlaceReviews(review: MyPlaceReviewRequest) -> AnyPublisher<ResponseData<MyPlaceReviewResponse>, Moya.MoyaError> {
        return repository.getMyPlaceReviewsData(review: review)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
}

