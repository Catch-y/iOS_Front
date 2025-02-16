//
//  MyPageUseCaseProtocol.swift
//  Catchy
//
//  Created by 권용빈 on 2/2/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// 마이페이지 UseCaseProtocol
protocol MyPageUseCaseProtocol {
    
    /// 프로필 조회
    func executeGetProfile() -> AnyPublisher<ResponseData<ProfileResponse>, MoyaError>
    
    /// 북마크한 코스 조회
    func executeGetBookmarkCourseList(pageSize: Int, lastCourseId: Int?) -> AnyPublisher<ResponseData<CourseResponse>, MoyaError>
    
    /// 북마크된 코스 무한 스크롤 API
    func executeGetMyReviews(review: MyReviewRequest) -> AnyPublisher<ResponseData<MyReviewResponse>, MoyaError>
}
