//
//  ReviewReportUseCase.swift
//  Catchy
//
//  Created by 권용빈 on 1/30/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

class ReviewReportUseCase: ReviewReportUseCaseProtocol {
    
    let repository: ReviewReportRepositoryProtocol
    
    init(repository: ReviewReportRepositoryProtocol = ReviewReportRepository()) {
        self.repository = repository
    }
    
    func executePostReviewReportInfo(reviewReportRequest: PostReviewReportRequest) -> AnyPublisher<ResponseData<ReviewReportResponse>, MoyaError> {
        return repository.postReviewReportInfoData(reviewReportRequest: reviewReportRequest)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
}
