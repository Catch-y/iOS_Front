//
//  ReviewService.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/17/25.
//

import Foundation
import Combine
import Moya

class ReviewService: ReviewServiceProtocol, BaseAPIService {
    typealias Target = ReviewRouter
    
    var provider: MoyaProvider<Target>
    var decoder: JSONDecoder
    var callbackQueue: DispatchQueue
    
    init(
        provider: MoyaProvider<Target> = APIManager.shared.createProvider(for: Target.self),
        decoder: JSONDecoder = APIManager.shared.sharedDecoder,
        callbackQueue: DispatchQueue = .main
    ) {
        self.provider = provider
        self.decoder = decoder
        self.callbackQueue = callbackQueue
    }
    
    func postReport(path: ReviewReportPath, review: ReviewReportRequest) -> AnyPublisher<ResponseData<ReviewReportResponse>, Moya.MoyaError> {
        request(.postReport(path: path, review: review))
    }
    
    func getMyPlace(query: ReviewMyPlaceQuery) -> AnyPublisher<ResponseData<ReviewMyPlaceResponse>, Moya.MoyaError> {
        request(.getMyPlace(query: query))
    }
    
    func getMyCourse(query: ReviewMyCourseQuery) -> AnyPublisher<ResponseData<ReviewMyPlaceResponse>, Moya.MoyaError> {
        request(.getMyCourse(query: query))
    }
    
    func deleteReview(path: ReviewDeletePath, query: ReviewDeleteQuery) -> AnyPublisher<ResponseData<ReviewDeleteResponse>, Moya.MoyaError> {
        request(.deleteReview(path: path, query: query))
    }
    
}
