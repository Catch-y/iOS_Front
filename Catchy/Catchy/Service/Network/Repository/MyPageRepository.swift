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
import SwiftUI

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
    
    /// 내 코스 리뷰 조회 API
    func getMyCourseReviewsData(review: MyCourseReviewRequest) -> AnyPublisher<ResponseData<MyCourseReviewResponse>, Moya.MoyaError> {
        return service.getMyCourseReviews(review: review)
    }
    
    /// 내 장소 리뷰 조회 API
    func getMyPlaceReviewsData(review: MyPlaceReviewRequest) -> AnyPublisher<ResponseData<MyPlaceReviewResponse>, Moya.MoyaError> {
        return service.getMyPlaceReviews(review: review)
    }
    
    func patchProfileImage(profileImage: UIImage) -> AnyPublisher<ResponseData<EditProfileResponse>, MoyaError> {
        return service.patchProfileImage(profileImage: profileImage)
    }
    
    /// 리뷰 삭제 API
    func deleteReviewData(reviewId: Int, reviewType: ReviewType) -> AnyPublisher<ResponseData<DeleteReviewResponse>, Moya.MoyaError> {
        return service.deleteReview(reviewId: reviewId, reviewType: reviewType)
    }
}
