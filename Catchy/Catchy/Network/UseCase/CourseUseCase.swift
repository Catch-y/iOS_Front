//
//  CourseUseCase.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/17/25.
//

import Foundation
import Moya
import Combine

class CourseUseCase: CourseUseCaseProtocol {
    private let service: CourseServiceProtocol
    
    init(service: CourseServiceProtocol = CourseService()) {
        self.service = service
    }
    
    /// 장소 카테고리 선택
    func executePostSelectCategory(path: CourseCategoryPath, category: CourseCategoryRequest) -> AnyPublisher<ResponseData<EmptyResponse>, Moya.MoyaError> {
        service.postSelectCategory(path: path, category: category)
    }
    
    /// 장소 리뷰 작성
    func executePostReview(path: CourseReviewWritePath, review: CourseReviewWriteRequest) -> AnyPublisher<ResponseData<CourseReviewWriteResponse>, Moya.MoyaError> {
        service.postReview(path: path, review: review)
    }
    
    /// 장소 방문체크
    func executePostVisited(path: CourseCheckPath) -> AnyPublisher<ResponseData<CourseCheckResponse>, Moya.MoyaError> {
        service.postVisited(path: path)
    }
    
    /// 코스 생성 DIY
    func executePostCoursePerson(course: CourseGenerateUserRequest) -> AnyPublisher<ResponseData<CourseGenerateUserResponse>, Moya.MoyaError> {
        service.postCoursePerson(course: course)
    }
    
    /// 코스 생성
    func executePostCourseAI() -> AnyPublisher<ResponseData<CourseGenerateUserResponse>, Moya.MoyaError> {
        service.postCourseAI()
    }
    
    /// 코스 삭제
    func executeDeleteCourse(path: CourseDeletePath) -> AnyPublisher<ResponseData<EmptyResponse>, Moya.MoyaError> {
        service.deleteCourse(path: path)
    }
    
    /// 코스 생성
    func executePatchModifyCourse(path: CourseModifyPath, course: CourseModifyRequest) -> AnyPublisher<ResponseData<CourseGenerateUserResponse>, Moya.MoyaError> {
        service.patchModifyCourse(path: path, course: course)
    }
    
    /// 코스 북마크
    func executePatchBookmark(path: CourseBookMarkPath) -> AnyPublisher<ResponseData<CourseBookMarkResponse>, Moya.MoyaError> {
        service.patchBookmark(path: path)
    }
    
    /// 코스 리뷰 전체 보기
    func executeGetCourseReview(path: CourseReviewAllPath, query: CourseReviewAllQuery) -> AnyPublisher<ResponseData<CourseReviewAllResponse>, Moya.MoyaError> {
        service.getCourseReview(path: path, query: query)
    }
    
    /// 인기 코스 조회
    func executeGetBestCourse() -> AnyPublisher<ResponseData<CourseBestResponse>, Moya.MoyaError> {
        service.getBestCourse()
    }
    
    /// 내 코스 조회
    func executeGetMyCourseList(query: CourseMyQuery) -> AnyPublisher<ResponseData<CourseMyResponse>, Moya.MoyaError> {
        service.getMyCourseList(query: query)
    }
    
    /// 홈 화면 추천 코스
    func executeGetHomeRecommendCourse() -> AnyPublisher<ResponseData<CourseRecommendResponse>, Moya.MoyaError> {
        service.getHomeRecommendCourse()
    }
    
    /// 코스 상세 정보 조회
    func executeGetCourseDetail(path: CourseDetailInfoPath) -> AnyPublisher<ResponseData<CourseGenerateUserResponse>, Moya.MoyaError> {
        service.getCourseDetail(path: path)
    }
    
    
}
