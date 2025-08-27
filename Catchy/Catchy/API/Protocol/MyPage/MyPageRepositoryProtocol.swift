//
//  MyPageRepositoryProtocol.swift
//  Catchy
//
//  Created by 권용빈 on 2/2/25.
//

import Foundation
import Combine
import CombineMoya
import Moya
import SwiftUI

/// 마이페이지 RepositoryProtocol
protocol MyPageRepositoryProtocol {
    
    /// 프로필 조회
    func getProfileData() -> AnyPublisher<ResponseData<ProfileResponse>, MoyaError>
    
    /// 북마크된 코스 무한 스크롤 API
    func getBookmarkCourseListData(pageSize: Int, lastCourseId: Int?) -> AnyPublisher<ResponseData<CourseResponse>, MoyaError>
    
    /// 내 코스 리뷰 조회 API
    func getMyCourseReviewsData(review: MyCourseReviewRequest) -> AnyPublisher<ResponseData<MyCourseReviewResponse>, MoyaError>
    
    /// 내 장소 리뷰 조회 API
    func getMyPlaceReviewsData(review: MyPlaceReviewRequest) -> AnyPublisher<ResponseData<MyPlaceReviewResponse>, MoyaError>
    
    func patchProfileImage(profileImage: UIImage) -> AnyPublisher<ResponseData<EditProfileResponse>, MoyaError>
    
    /// 리뷰 삭제 API
    func deleteReviewData(reviewId: Int, reviewType: ReviewType) -> AnyPublisher<ResponseData<DeleteReviewResponse>, MoyaError>
}

