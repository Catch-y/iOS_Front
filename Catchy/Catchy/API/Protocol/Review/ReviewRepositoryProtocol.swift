//
//  ReviewRepositoryProtocol.swift
//  Catchy
//
//  Created by 권용빈 on 1/26/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

protocol ReviewRepositoryProtocol {
    
    /// 장소 리뷰 전체보기 API
    func getPlaceReviewInfoData(placeId: Int, request: PlaceReviewRequest) -> AnyPublisher<ResponseData<PlaceReviewInfoResponse>, MoyaError>
    
    /// 코스 리뷰 전체보기 API
    func getCourseReviewInfoData(courseId: Int, pageSize: Int, lastReviewId: Int?) -> AnyPublisher<ResponseData<CourseReviewInfoResponse>, MoyaError>
    
    /// 리뷰 신고하기
    func postReviewReportData(reviewId: Int, request: ReviewReportRequest) -> AnyPublisher<ResponseData<ReviewReportResponse>, MoyaError>
}
