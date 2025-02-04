//
//  MyPageUseCase.swift
//  Catchy
//
//  Created by 권용빈 on 2/2/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [코스 관리] UseCase 객체
class MyPageUseCase: MyPageUseCaseProtocol {

    let repository: MyPageRepositoryProtocol
    
    init(repository: MyPageRepositoryProtocol = MyPageRepository()) {
        self.repository = repository
    }
    
    /// 코스 조회
    func executeGetProfile() -> AnyPublisher<ResponseData<ProfileResponse>, Moya.MoyaError> {
        return repository.getProfileData()
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    func executeGetBookmarkCourseList(pageSize: Int, lastCourseId: Int? = nil) -> AnyPublisher<ResponseData<CourseResponse>, Moya.MoyaError> {
        return repository.getBookmarkCourseListData(pageSize: pageSize, lastCourseId: lastCourseId)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
}

