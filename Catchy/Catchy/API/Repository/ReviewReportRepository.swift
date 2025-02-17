//
//  ReviewReportRepository.swift
//  Catchy
//
//  Created by 권용빈 on 1/30/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

class ReviewReportRepository: ReviewReportRepositoryProtocol {
    let service: ReviewReportServiceProtocol
    
    init(service: ReviewReportServiceProtocol = ReviewReportService()) {
        self.service = service
    }
    
    func postReviewReportInfoData(reviewReportRequest: PostReviewReportRequest) -> AnyPublisher<ResponseData<ReviewReportResponse>, MoyaError> {
        return service.postReviewReportInfo(reviewReportRequest: reviewReportRequest)
    }
}
