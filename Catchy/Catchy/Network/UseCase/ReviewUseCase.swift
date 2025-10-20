//
//  ReviewUseCase.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/17/25.
//

import Foundation
import Moya
import Combine

class ReviewUseCase: ReviewUseCaseProtocol {
    private let service: ReviewServiceProtocol
    
    init(service: ReviewServiceProtocol = ReviewService()) {
        self.service = service
    }
     
    /// 리뷰 신고
    func executePostReport(path: ReviewReportPath, review: ReviewReportRequest) -> AnyPublisher<ResponseData<ReviewReportResponse>, Moya.MoyaError> {
        service.postReport(path: path, review: review)
    }
    
    /// 내 장소 리뷰 조회
    func executeGetMyPlace(query: ReviewMyPlaceQuery) -> AnyPublisher<ResponseData<ReviewMyPlaceResponse>, Moya.MoyaError> {
        service.getMyPlace(query: query)
    }
    
    /// 내 코스 리뷰 조회
    func executeGetMyCourse(query: ReviewMyCourseQuery) -> AnyPublisher<ResponseData<ReviewMyPlaceResponse>, Moya.MoyaError> {
        service.getMyCourse(query: query)
    }
    
    /// 리뷰 삭제
    func executeDeleteReview(path: ReviewDeletePath, query: ReviewDeleteQuery) -> AnyPublisher<ResponseData<ReviewDeleteResponse>, Moya.MoyaError> {
        service.deleteReview(path: path, query: query)
    }
    
    
}
