//
//  CourseRepository.swift
//  Catchy
//
//  Created by LEE on 1/25/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [Course] Repository 객체
class CourseRepository: CourseRepositoryProtocol {
    
    let provider: CourseServiceProtocol
    
    init(provider: CourseServiceProtocol = CourseService()){
        self.provider = provider
    }
    
    /// 장소 카테고리 선택 API
    func postPlaceCategoryRegisterData(place: PlaceCategoryRegisterRequest) -> AnyPublisher<ResponseData<PlaceCategoryRegisterResponse>, MoyaError> {
        return provider.postPlaceCategoryRegister(place: place)
    }
    
    /// 코스 리뷰 작성 API
    func postCourseReviewData(course: CourseReviewRequest) -> AnyPublisher<ResponseData<CourseReviewResponse>, MoyaError> {
        return provider.postCourseReview(course: course)
    }
    
    /// 코스 생성(DIY) API
    func postCreateCourseDIYData(course: CourseDIYCreateRequest) -> AnyPublisher<ResponseData<CourseDIYCreateResponse>, MoyaError> {
        return provider.postCreateCourseDIY(course: course)
    }
    
    /// 코스 생성(AI) API
    func postCreateCourseAIData() -> AnyPublisher<ResponseData<CourseAICreateResponse>, MoyaError> {
        return provider.postCreateCourseAI()
    }
    
    /// 코스 삭제 API
    func deleteCourseData(courseId: Int) -> AnyPublisher<ResponseData<CourseDeleteResponse>, MoyaError> {
        return provider.deleteCourse(courseId: courseId)
    }
    
    /// 코스 수정 API
    func patchCourseEditData(course: CourseEditRequest) -> AnyPublisher<ResponseData<CourseEditResponse>, MoyaError> {
        return provider.patchCourseEdit(course: course)
    }
    
    /// 코스 북마크 API
    func patchCourseBookmarkData(courseId: Int) -> AnyPublisher<ResponseData<CourseBookmarkResponse>, MoyaError> {
        return provider.patchCourseBookmark(courseId: courseId)
    }
    
    /// 장소 방문체크 API
    func patchPlaceVisitData(placeId: Int) -> AnyPublisher<ResponseData<PlaceVisitResponse>, MoyaError> {
        return provider.patchPlaceVisit(placeId: placeId)
    }
    
    /// 내 코스 조회 API
    func getCourseListData(courseRequest: CourseRequest) -> AnyPublisher<ResponseData<CourseResponse>, MoyaError> {
        return provider.getCourseList(courseRequest: courseRequest)
    }
    
    /// 장소 검색 - 지역명 기반
    func getPlaceListData(placeSearchRequest: PlaceSearchRequest) -> AnyPublisher<ResponseData<PlaceSearchResponse>, MoyaError> {
        return provider.getPlaceList(placeSearchRequest: placeSearchRequest)
    }
    
}
