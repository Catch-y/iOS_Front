//
//  RouteUseCaseProtocol.swift
//  Catchy
//
//  Created by 정의찬 on 2/19/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

protocol RouteUseCaseProtocol {
    func executeOsrmRouter(locationData: OSRMRequest) -> AnyPublisher<ResponseData<OSRMResponse>, MoyaError>
}
