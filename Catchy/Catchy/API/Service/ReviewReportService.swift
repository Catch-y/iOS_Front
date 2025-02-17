//
//  ReviewReportService.swift
//  Catchy
//
//  Created by 권용빈 on 1/30/25.
//

import Foundation
import Moya
import Combine
import CombineMoya

class ReviewReportService: ReviewReportServiceProtocol {
    
    let provider: MoyaProvider<ReviewReportAPITarget>
    
    init(provider: MoyaProvider<ReviewReportAPITarget> = APIManager.shared.testProvider(for: ReviewReportAPITarget.self)) {
        self.provider = provider
    }
    
    func postReviewReportInfo(reviewReportRequest: PostReviewReportRequest) -> AnyPublisher<ResponseData<ReviewReportResponse>, Moya.MoyaError> {
        return provider.requestPublisher(.postReviewReportInfo(request: reviewReportRequest))
            .map(ResponseData<ReviewReportResponse>.self)
            .eraseToAnyPublisher()
    }
}
