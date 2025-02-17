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

protocol ReviewServiceProtocol {
    // 리뷰 정보 가져오기
    func getReviewInfo(reviewData: GetReviewRequest) -> AnyPublisher<ResponseData<ReviewResponse>, MoyaError>
}
