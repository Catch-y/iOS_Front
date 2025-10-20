//
//  ReviewServiceProtocol.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/17/25.
//

import Foundation
import Moya
import Combine

protocol ReviewServiceProtocol {
    func postReport(path: ReviewReportPath, review: ReviewReportRequest) -> AnyPublisher<ResponseData<ReviewReportResponse>, MoyaError>
    
    func getMyPlace(query: ReviewMyPlaceQuery) -> AnyPublisher<ResponseData<ReviewMyPlaceResponse>, MoyaError>
    
    func getMyCourse(query: ReviewMyCourseQuery) -> AnyPublisher<ResponseData<ReviewMyPlaceResponse>, MoyaError>
    
    func deleteReview(path: ReviewDeletePath, query: ReviewDeleteQuery) -> AnyPublisher<ResponseData<ReviewDeleteResponse>, MoyaError>
}
