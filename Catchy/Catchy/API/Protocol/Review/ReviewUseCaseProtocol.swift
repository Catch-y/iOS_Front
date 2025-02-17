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

protocol ReviewUseCaseProtocol {
    // 리뷰 정보 가져오기
    func executeReviewResponse(reviewData: GetReviewRequest) -> AnyPublisher<ResponseData<ReviewResponse>, MoyaError>
}
