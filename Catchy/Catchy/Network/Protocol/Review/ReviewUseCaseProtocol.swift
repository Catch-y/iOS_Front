//
//  ReviewUseCaseProtocol.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/17/25.
//

import Foundation
import Moya
import Combine

protocol ReviewUseCaseProtocol {
    func executePostReport(path: ReviewReportPath, review: ReviewReportRequest) -> AnyPublisher<ResponseData<ReviewReportResponse>, MoyaError>
    
    func executeGetMyPlace(query: ReviewMyPlaceQuery) -> AnyPublisher<ResponseData<ReviewMyPlaceResponse>, MoyaError>
    
    func executeGetMyCourse(query: ReviewMyCourseQuery) -> AnyPublisher<ResponseData<ReviewMyPlaceResponse>, MoyaError>
    
    func executeDeleteReview(path: ReviewDeletePath, query: ReviewDeleteQuery) -> AnyPublisher<ResponseData<ReviewDeleteResponse>, MoyaError>
}
