//
//  HomeServiceProtocol.swift
//  Catchy
//
//  Created by 정의찬 on 2/4/25.
//

import Foundation
import Combine
import Moya

protocol HomeRepositoryProtocol {
    /* 행동 데이터 반영 장소 검색 */
    func getSearchData(keyword: String) -> AnyPublisher<ResponseData<SearchPlaceResponse>, MoyaError>
    
    /* 홈화면 추천 코스 */
    func getHomePersonalCoursesData() -> AnyPublisher<ResponseData<[CourseInfoResponse]>, MoyaError>
    
    /* 홈 화면 인기 코스 조회 10 */
    func getHomeCourseTopTenData() -> AnyPublisher<ResponseData<[PopularCourseResponse]>, MoyaError>
    
    /* 사용자 장소 추천 API */
    func getRecommendPlacesData(userLocation: UserLocation, page: Int) -> AnyPublisher<ResponseData<RecommendPlaceResponse>, MoyaError>
    
}
