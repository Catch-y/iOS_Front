//
//  CourseService.swift
//  Catchy
//
//  Created by LEE on 1/25/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [Course] Service 객체
class CourseService: CourseServiceProtocol {
    
    let provider: MoyaProvider<CourseAPITarget>
    
    init(provider: MoyaProvider<CourseAPITarget> = APIManager.shared.testProvider(for: CourseAPITarget.self)){
        self.provider = provider
    }
    
    /// 장소 카테고리 선택 API
    func postPlaceCategoryRegister(place: PlaceCategoryRegisterRequest) -> AnyPublisher<ResponseData<PlaceCategoryRegisterResponse>, MoyaError> {
        return provider.requestPublisher(.postPlaceCategoryRegister(place: place))
            .map(ResponseData<PlaceCategoryRegisterResponse>.self)
            .eraseToAnyPublisher()
    }
    
    /// 코스 리뷰 작성 API
    func postCourseReview(course: CourseReviewRequest) -> AnyPublisher<ResponseData<CourseReviewResponse>, MoyaError> {
        return provider.requestPublisher(.postCourseReview(course: course))
            .map(ResponseData<CourseReviewResponse>.self)
            .eraseToAnyPublisher()
    }
    
    /// 코스 생성(DIY) API
    func postCreateCourseDIY(course: CourseDIYCreateRequest) -> AnyPublisher<ResponseData<CourseDIYCreateResponse>, MoyaError> {
        return provider.requestPublisher(.postCreateCourseDIY(course: course))
            .map(ResponseData<CourseDIYCreateResponse>.self)
            .eraseToAnyPublisher()
    }
    
    /// 코스 생성(AI) API
    func postCreateCourseAI() -> AnyPublisher<ResponseData<CourseAICreateResponse>, MoyaError> {
        return provider.requestPublisher(.postCreateCourseAI)
            .map(ResponseData<CourseAICreateResponse>.self)
            .eraseToAnyPublisher()
    }
    
    /// 코스 삭제 API
    func deleteCourse(courseId: Int) -> AnyPublisher<ResponseData<CourseDeleteResponse>, MoyaError> {
        return provider.requestPublisher(.deleteCourse(courseId: courseId))
            .map(ResponseData<CourseDeleteResponse>.self)
            .eraseToAnyPublisher()
    }
    
    /// 코스 수정 API
    func patchCourseEdit(course: CourseEditRequest) -> AnyPublisher<ResponseData<CourseEditResponse>, MoyaError> {
        return provider.requestPublisher(.patchCourseEdit(course: course))
            .map(ResponseData<CourseEditResponse>.self)
            .eraseToAnyPublisher()
    }
    
    /// 코스 북마크 API
    func patchCourseBookmark(courseId: Int) -> AnyPublisher<ResponseData<CourseBookmarkResponse>, MoyaError> {
        return provider.requestPublisher(.patchCourseBookmark(courseId: courseId))
            .map(ResponseData<CourseBookmarkResponse>.self)
            .eraseToAnyPublisher()
    }
    
    /// 장소 방문체크 API
    func patchPlaceVisit(placeId: Int) -> AnyPublisher<ResponseData<PlaceVisitResponse>, MoyaError> {
        return provider.requestPublisher(.patchPlaceVisit(placeId: placeId))
            .map(ResponseData<PlaceVisitResponse>.self)
            .eraseToAnyPublisher()
    }
    
    
    /// 내 코스 조회 API
    func getCourseList(courseRequest: CourseRequest) -> AnyPublisher<ResponseData<CourseResponse>, MoyaError> {
        return provider.requestPublisher(.getCourseList(course: courseRequest))
            .map(ResponseData<CourseResponse>.self)
            .eraseToAnyPublisher()
            
    }
    
    /// 코스 상세정보 조회 API
    func getPlaceDetail(placeId: Int) -> AnyPublisher<ResponseData<PlaceDetailResponse>, MoyaError> {
        return provider.requestPublisher(.getPlaceDetail(placeId: placeId))
            .map(ResponseData<PlaceDetailResponse>.self)
            .eraseToAnyPublisher()
    }
 
    
}
