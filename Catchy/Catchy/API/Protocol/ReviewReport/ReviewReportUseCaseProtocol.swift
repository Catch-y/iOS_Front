//
//  ReviewUseCaseProtocol.swift
//  Catchy
//
//  Created by 권용빈 on 1/26/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

protocol ReviewReportUseCaseProtocol {
    func executePostReviewReportInfo(reviewReportRequest: PostReviewReportRequest) -> AnyPublisher<ResponseData<ReviewReportResponse>, MoyaError>
}
