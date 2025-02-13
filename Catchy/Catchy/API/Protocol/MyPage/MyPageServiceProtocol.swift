//
//  MyPageServiceProtocol.swift
//  Catchy
//
//  Created by 권용빈 on 2/2/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// 마이페이지 ServiceProtocol
protocol MyPageServiceProtocol {
    
    /// 프로필 조회
    func getProfile() -> AnyPublisher<ResponseData<ProfileResponse>, MoyaError>
    
    /// 북마크된 코스 무한 스크롤 API
    func getBookmarkCourseList(pageSize: Int, lastCourseId: Int?) -> AnyPublisher<ResponseData<CourseResponse>, MoyaError>
    
    /// 내 리뷰 조회 API
    func getMyReviews(review: MyReviewRequest) -> AnyPublisher<ResponseData<MyReviewResponse>, MoyaError>
}
