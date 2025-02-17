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

protocol ReviewRepositoryProtocol {
    // 리뷰 정보 가져오기
    func getReviewInfoData(reviewData: GetReviewRequest) -> AnyPublisher<ResponseData<ReviewResponse>, MoyaError>
}
