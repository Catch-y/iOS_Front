//
//  HomeServiceProtocol.swift
//  Catchy
//
//  Created by 정의찬 on 2/4/25.
//

import Foundation
import Combine
import Moya

protocol HomeServiceProtocol {
    func getSearch(keyword: String) -> AnyPublisher<ResponseData<SearchPlaceResponse>, MoyaError>
}
