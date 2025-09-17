//
//  CourseRouter.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/10/25.
//

import Foundation
import Moya

enum CourseRouter {
    /// 장소 카테고리 선택
    case postSelectCategory(path: CourseCategoryPath, category: CourseCategoryRequest)
    /// 코스 리뷰 작성
    case postReview(path: CourseReviewWritePath, review: CourseReviewWriteRequest)
    /// 장소 방문체크
    case postVisited(path: CourseCheckPath)
    /// 코스 생성 DIY API
    case postCoursePerson(course: CourseGenerateUserRequest)
    /// 코스 생성 API
    case postCourseAI
    /// 코스 삭제 API
    case deleteCourse(path: CourseDeletePath)
    /// 코스 수정 API
    case patchModifyCourse(path: CourseModifyPath, course: CourseModifyRequest)
    /// 코스 북마크
    case patchBookmark(path: CourseBookMarkPath)
    /// 코스 리뷰 전체보기
    case getCourseReview(path: CourseReviewAllPath, query: CourseReviewAllQuery)
    /// 인기 코스 조회
    case getBestCourse
    /// 내 코스 조회
    case getMyCourseList(query: CourseMyQuery)
    /// 홈 화면 추천 코스
    case getHomeRecommendCourse
    /// 코스 상세 정보 조회
    case getCourseDetail(path: CourseDetailInfoPath)
}

extension CourseRouter: APITargetType {
    var path: String {
        switch self {
        case .postSelectCategory(let path, _):
            return "/course/\(path.placeId)"
        case .postReview(let path, _):
            return "/course/\(path.courseId)/review"
        case .postVisited(let path):
            return "/course/visited/\(path.courseId)/\(path.placeId)"
        case .postCoursePerson:
            return "/course/in-person"
        case .postCourseAI:
            return "/course/generate-ai"
        case .deleteCourse(let path):
            return "/course/\(path.courseId)"
        case .patchModifyCourse(let path, _):
            return "/course/\(path.courseId)"
        case .patchBookmark(let path):
            return "/course/\(path.courseId)/bookmark"
        case .getCourseReview(let path, _):
            return "/course/\(path.courseId)/review/all"
        case .getBestCourse:
            return "/course/top10"
        case .getMyCourseList:
            return "/course/search"
        case .getHomeRecommendCourse:
            return "/course/home/personal-courses"
        case .getCourseDetail(let path):
            return "/course/detail/\(path.courseId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postSelectCategory, .postReview, .postVisited, .postCourseAI:
            return .post
        case .deleteCourse:
            return .delete
        case .patchModifyCourse, .patchBookmark:
            return .patch
        default:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postSelectCategory(_, let category):
            return .requestJSONEncodable(category)
        case .postReview(_, let review):
            return .uploadMultipart(review.asMultipartFormData())
        case .postCoursePerson(let course):
            return .uploadMultipart(course.asMultipartFormData())
        case .patchModifyCourse(_, let course):
            return .uploadMultipart(course.asMultipartFormData())
        case .getCourseReview(_, let query):
            return query.asQueryTask()
        case .getMyCourseList(let query):
            return query.asQueryTask()
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .postReview, .postCoursePerson, .patchModifyCourse:
            return ["Content-Type": "multipart/form-data"]
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
