//
//  HomeUseCase.swift
//  Catchy
//
//  Created by 정의찬 on 2/4/25.
//

import Foundation
import Moya
import Combine

class HomeUseCase: HomeUseCaseProtocol {
    let repository: HomeRepositoryProtocol
    
    init(repository: HomeRepositoryProtocol = HomeRepository()) {
        self.repository = repository
    }
    
    func executeGetSearch(keyword: String, page: Int) -> AnyPublisher<ResponseData<SearchPlaceResponse>, MoyaError> {
        return repository.getSearchData(keyword: keyword, page: page)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    func executeHomePersonalCourses() -> AnyPublisher<ResponseData<[CourseInfoResponse]>, MoyaError> {
        return repository.getHomePersonalCoursesData()
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    func executeGetHomeCourseTopTen() -> AnyPublisher<ResponseData<[PopularCourseResponse]>, MoyaError> {
        return repository.getHomeCourseTopTenData()
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    func executeGetRecommendPlaces(userLocation: UserLocation, page: Int) -> AnyPublisher<ResponseData<RecommendPlaceResponse>, MoyaError> {
        return repository.getRecommendPlacesData(userLocation: userLocation, page: page)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
}
