//
//  HomeService.swift
//  Catchy
//
//  Created by 정의찬 on 2/4/25.
//

import Foundation
import Combine
import Moya

class HomeService: HomeServiceProtocol {
    private let provider: MoyaProvider<HomeAPITarget>
    
    init(provider: MoyaProvider<HomeAPITarget> = APIManager.shared.testProvider(for: HomeAPITarget.self)) {
        self.provider = provider
    }
    
    func getSearch(keyword: String) -> AnyPublisher<ResponseData<SearchPlaceResponse>, MoyaError> {
        return provider.requestPublisher(.getSearch(keyword: keyword))
            .map(ResponseData<SearchPlaceResponse>.self)
            .eraseToAnyPublisher()
    }
}
