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

protocol ReviewReportServiceProtocol {
    func postReviewReportInfo(reviewReportRequest: PostReviewReportRequest) -> AnyPublisher<ResponseData<ReviewReportResponse>, MoyaError>
}
