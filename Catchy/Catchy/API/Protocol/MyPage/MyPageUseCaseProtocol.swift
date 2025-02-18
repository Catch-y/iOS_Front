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
import SwiftUI

/// 마이페이지 UseCaseProtocol
protocol MyPageUseCaseProtocol {
    
    /// 프로필 조회
    func executeGetProfile() -> AnyPublisher<ResponseData<ProfileResponse>, MoyaError>
    
    /// 북마크된 코스 무한 스크롤 API
    func executeGetBookmarkCourseList(pageSize: Int, lastCourseId: Int?) -> AnyPublisher<ResponseData<CourseResponse>, MoyaError>
    
    /// 내 코스 리뷰 조회 API
    func executeGetMyCourseReviews(review: MyCourseReviewRequest) -> AnyPublisher<ResponseData<MyCourseReviewResponse>, MoyaError>
    
    /// 내 리뷰 조회 API
    func executeGetMyPlaceReviews(review: MyPlaceReviewRequest) -> AnyPublisher<ResponseData<MyPlaceReviewResponse>, MoyaError>
    
    func executePatchProfileImage(profileImage: UIImage) -> AnyPublisher<ResponseData<EditProfileResponse>, MoyaError>
}
