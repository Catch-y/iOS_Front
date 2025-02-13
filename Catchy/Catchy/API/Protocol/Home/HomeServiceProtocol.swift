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
    /* 행동 데이터 반영 장소 검색 */
    func getSearch(keyword: String, page: Int) -> AnyPublisher<ResponseData<SearchPlaceResponse>, MoyaError>
    
    /* 홈화면 추천 코스 */
    func getHomePersonalCourses() -> AnyPublisher<ResponseData<[CourseInfoResponse]>, MoyaError>
    
    /* 홈 화면 인기 코스 조회 10 */
    func getHomeCourseTopTen() -> AnyPublisher<ResponseData<[PopularCourseResponse]>, MoyaError>
    
    /* 사용자 장소 추천 API */
    func getRecommendPlaces(userLocation: UserLocation, page: Int) -> AnyPublisher<ResponseData<RecommendPlaceResponse>, MoyaError>
}
