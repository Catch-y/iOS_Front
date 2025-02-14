//
//  MyPageRepository.swift
//  Catchy
//
//  Created by 권용빈 on 2/2/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// 마이페이지 Repository 객체
class MyPageRepository: MyPageRepositoryProtocol {
    
    let service: MyPageServiceProtocol
    
    init(service: MyPageServiceProtocol = MyPageService()){
        self.service = service
    }
    
    /// 프로필 조회
    func getProfileData() -> AnyPublisher<ResponseData<ProfileResponse>, MoyaError> {
        return service.getProfile()
    }
    
    /// 북마크된 코스 무한 스크롤 API
    func getBookmarkCourseListData(pageSize: Int, lastCourseId: Int? = nil) -> AnyPublisher<ResponseData<CourseResponse>, Moya.MoyaError> {
        return service.getBookmarkCourseList(pageSize: pageSize, lastCourseId: lastCourseId)
    }
    
    /// 내 리뷰 조회 API
    func getMyReviewsData(review: MyReviewRequest) -> AnyPublisher<ResponseData<MyReviewResponse>, Moya.MoyaError> {
        return service.getMyReviews(review: review)
    }
}
