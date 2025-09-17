//
//  PlaceCourseUseCaseProtocol.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/17/25.
//

import Foundation
import Moya
import Combine

protocol PlaceCourseUseCaseProtocol {
    /// 장소 상세 화면
    func executeGetDetailPlace(path: PlaceCourseDetailPath) -> AnyPublisher<ResponseData<PlaceCourseDetailResponse>, MoyaError>
    /// 지역명 기반 장소
    func executeGetSearchPlace(query: PlaceCourseSearchQuery) -> AnyPublisher<ResponseData<PlaceCourseSearchResponse>, MoyaError>
    /// 좋아요 장소 무한 스크롤
    func executeGetLikeScroll(query: PlaceCourseLikeQuery) -> AnyPublisher<ResponseData<PlaceCourseLikeResponse>, MoyaError>
    /// 내 위치 기반 장소 검색
    func executeGetCurrentLocation(query: PlaceCourseCurrentSearchQuery) -> AnyPublisher<ResponseData<PlaceCourseSearchResponse>, MoyaError>
}
