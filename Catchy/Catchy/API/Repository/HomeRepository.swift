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
    
    func getSearchData(keyword: String, page: Int, relevanceScore: Int?, lastPlaceId: Int?) -> AnyPublisher<ResponseData<SearchPlaceResponse>, MoyaError> {
        return service.getSearch(keyword: keyword, page: page, relevanceScore: relevanceScore, lastPlaceId: lastPlaceId)
    }
    
    func getHomePersonalCoursesData() -> AnyPublisher<ResponseData<[CourseInfoResponse]>, MoyaError> {
        return service.getHomePersonalCourses()
    }
    
    func getHomeCourseTopTenData() -> AnyPublisher<ResponseData<[PopularCourseResponse]>, MoyaError> {
        return service.getHomeCourseTopTen()
    }
    
    func getRecommendPlacesData(userLocation: UserLocation, page: Int) -> AnyPublisher<ResponseData<RecommendPlaceResponse>, MoyaError> {
        return service.getRecommendPlaces(userLocation: userLocation, page: page)
    }
}
