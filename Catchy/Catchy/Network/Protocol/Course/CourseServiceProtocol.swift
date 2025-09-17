//
//  CourseServiceProtocol.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/17/25.
//

import Foundation
import Moya
import Combine

protocol CourseServiceProtocol {
    /// 장소 카테고리 선택
    func postSelectCategory(path: CourseCategoryPath, category: CourseCategoryRequest) -> AnyPublisher<ResponseData<EmptyResponse>, MoyaError>
    /// 코스 리뷰 작성
    func postReview(path: CourseReviewWritePath, review: CourseReviewWriteRequest) -> AnyPublisher<ResponseData<CourseReviewWriteResponse>, MoyaError>
    /// 장소 방문체크
    func postVisited(path: CourseCheckPath) -> AnyPublisher<ResponseData<CourseCheckResponse>, MoyaError>
    /// 코스 생성 DIY API
    func postCoursePerson(course: CourseGenerateUserRequest) -> AnyPublisher<ResponseData<CourseGenerateUserResponse>, MoyaError>
    /// 코스 생성 API
    func postCourseAI() -> AnyPublisher<ResponseData<CourseGenerateUserResponse>, MoyaError>
    /// 코스 삭제 API
    func deleteCourse(path: CourseDeletePath) -> AnyPublisher<ResponseData<EmptyResponse>, MoyaError>
    /// 코스 수정 API
    func patchModifyCourse(path: CourseModifyPath, course: CourseModifyRequest) -> AnyPublisher<ResponseData<CourseGenerateUserResponse>, MoyaError>
    /// 코스 북마크
    func patchBookmark(path: CourseBookMarkPath) -> AnyPublisher<ResponseData<CourseBookMarkResponse>, MoyaError>
    /// 코스 리뷰 전체보기
    func getCourseReview(path: CourseReviewAllPath, query: CourseReviewAllQuery) -> AnyPublisher<ResponseData<CourseReviewAllResponse>, MoyaError>
    /// 인기 코스 조회
    func getBestCourse() -> AnyPublisher<ResponseData<CourseBestResponse>, MoyaError>
    /// 내 코스 조회
    func getMyCourseList(query: CourseMyQuery) -> AnyPublisher<ResponseData<CourseMyResponse>, MoyaError>
    /// 홈 화면 추천 코스
    func getHomeRecommendCourse() -> AnyPublisher<ResponseData<CourseRecommendResponse>, MoyaError>
    /// 코스 상세 정보 조회
    func getCourseDetail(path: CourseDetailInfoPath) -> AnyPublisher<ResponseData<CourseGenerateUserResponse>, MoyaError>
}
