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
    // 리뷰 신고하기
    func postReviewReportInfoData(reviewReportRequest: PostReviewReportRequest) -> AnyPublisher<ResponseData<ReviewReportResponse>, MoyaError>
}
