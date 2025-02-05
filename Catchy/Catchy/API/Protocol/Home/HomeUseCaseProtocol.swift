//
//  HomeServiceProtocol.swift
//  Catchy
//
//  Created by 정의찬 on 2/4/25.
//

import Foundation
import Combine
import Moya

protocol HomeUseCaseProtocol {
    func executeGetSearch(keyword: String) -> AnyPublisher<ResponseData<SearchPlaceResponse>, MoyaError>
}
