//
//  HomeRepository.swift
//  Catchy
//
//  Created by 정의찬 on 2/4/25.
//

import Foundation
import Combine
import Moya

class HomeRepository: HomeRepositoryProtocol {
    let service: HomeServiceProtocol
    
    init(service: HomeServiceProtocol = HomeService()) {
        self.service = service
    }
    
    func getSearchData(keyword: String) -> AnyPublisher<ResponseData<SearchPlaceResponse>, MoyaError> {
        return service.getSearch(keyword: keyword)
    }
    
}
