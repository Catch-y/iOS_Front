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
    
    func getSearch(keyword: String, page: Int) -> AnyPublisher<ResponseData<SearchPlaceResponse>, MoyaError> {
        return provider.requestPublisher(.getSearch(keyword: keyword, page: page))
            .map(ResponseData<SearchPlaceResponse>.self)
            .eraseToAnyPublisher()
    }
    
    func getHomePersonalCourses() -> AnyPublisher<ResponseData<[CourseInfoResponse]>, MoyaError> {
        return provider.requestPublisher(.getHomePersonalCourses)
            .map(ResponseData<[CourseInfoResponse]>.self)
            .eraseToAnyPublisher()
    }
    
    func getHomeCourseTopTen() -> AnyPublisher<ResponseData<[PopularCourseResponse]>, MoyaError> {
        return provider.requestPublisher(.getHomeCourseTopTen)
            .map(ResponseData<[PopularCourseResponse]>.self)
            .eraseToAnyPublisher()
    }
    
    func getRecommendPlaces(userLocation: UserLocation, page: Int) -> AnyPublisher<ResponseData<RecommendPlaceResponse>, MoyaError> {
        return provider.requestPublisher(.getRecommendPlaces(userLocation: userLocation, page: page))
            .map(ResponseData<RecommendPlaceResponse>.self)
            .eraseToAnyPublisher()
    }
}
