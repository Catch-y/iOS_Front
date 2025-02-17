//
//  ReviewServiceProtocol.swift
//  Catchy
//
//  Created by 권용빈 on 1/25/25.
//

import Foundation
import CombineMoya
import Combine
import Moya

protocol ReviewServiceProtocol {
    
    /// 장소 리뷰 전체보기
    func getPlaceReviewInfo(placeId: Int, request: PlaceReviewRequest) -> AnyPublisher<ResponseData<PlaceReviewInfoResponse>, MoyaError>
    
    /// 코스 리뷰 전체보기
    func getCourseReviewInfo(courseId: Int, pageSize: Int, lastReviewId: Int?) -> AnyPublisher<ResponseData<CourseReviewInfoResponse>, MoyaError>
    
    /// 리뷰 신고하기
    func postReviewReport(reviewId: Int, request: ReviewReportRequest) -> AnyPublisher<ResponseData<ReviewReportResponse>, MoyaError>
}

