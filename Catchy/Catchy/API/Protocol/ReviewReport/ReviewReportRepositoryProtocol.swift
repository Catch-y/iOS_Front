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

protocol ReviewReportRepositoryProtocol {
    func postReviewReportInfoData(reviewReportRequest: PostReviewReportRequest) -> AnyPublisher<ResponseData<ReviewReportResponse>, MoyaError>
}
