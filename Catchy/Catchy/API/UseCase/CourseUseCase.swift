//
//  CourseUseCase.swift
//  Catchy
//
//  Created by LEE on 1/25/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [Course] UseCase 객체
class CourseUseCase: CourseUseCaseProtocol {
    
    let repository: CourseRepositoryProtocol
    
    init(repository: CourseRepositoryProtocol = CourseRepository()) {
        self.repository = repository
    }
    
    /// 장소 카테고리 선택 API
    func executePostPlaceCategoryRegister(place: PlaceCategoryRegisterRequest) -> AnyPublisher<ResponseData<PlaceCategoryRegisterResponse>, MoyaError> {
        return repository.postPlaceCategoryRegisterData(place: place)
    }
    
    /// 코스 리뷰 작성 API
    func executePostCourseReview(course: CourseReviewRequest) -> AnyPublisher<ResponseData<CourseReviewResponse>, MoyaError> {
        return repository.postCourseReviewData(course: course)
    }
    
    /// 코스 생성(DIY) API
    func executePostCreateCourseDIY(course: CourseDIYCreateRequest) -> AnyPublisher<ResponseData<CourseDIYCreateResponse>, MoyaError> {
        return repository.postCreateCourseDIYData(course: course)
    }
    
    /// 코스 생성(AI) API
    func executePostCreateCourseAI() -> AnyPublisher<ResponseData<CourseAICreateResponse>, MoyaError> {
        return repository.postCreateCourseAIData()
    }
    
    /// 코스 삭제 API
    func executeDeleteCourse(courseId: Int) -> AnyPublisher<ResponseData<CourseDeleteResponse>, MoyaError> {
        return repository.deleteCourseData(courseId: courseId)
        
    }
    
    /// 코스 수정 API
    func executePatchCourseEdit(course: CourseEditRequest) -> AnyPublisher<ResponseData<CourseEditResponse>, MoyaError> {
        return repository.patchCourseEditData(course: course)
    }
    
    /// 코스 북마크 API
    func executePatchCourseBookmark(courseId: Int) -> AnyPublisher<ResponseData<CourseBookmarkResponse>, MoyaError> {
        return repository.patchCourseBookmarkData(courseId: courseId)
    }
    
    /// 장소 방문체크 API
    func executePatchPlaceVisit(placeId: Int) -> AnyPublisher<ResponseData<PlaceVisitResponse>, MoyaError> {
        return repository.patchPlaceVisitData(placeId: placeId)
    }
    
    /// 코스 조회
    func executeGetCourseList(courseRequest: CourseRequest) -> AnyPublisher<ResponseData<CourseResponse>, MoyaError> {
        
        return repository.getCourseListData(courseRequest: courseRequest)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    /// 장소 검색 - 지역명 기반
    func executeGetPlaceList(placeSearchRequest: PlaceSearchRequest) -> AnyPublisher<ResponseData<PlaceSearchResponse>, MoyaError> {
        return repository.getPlaceListData(placeSearchRequest: placeSearchRequest)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
}

