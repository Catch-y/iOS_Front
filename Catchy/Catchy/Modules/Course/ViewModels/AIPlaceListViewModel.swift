//
//  AICourseCreateViewModel.swift
//  Catchy
//
//  Created by LEE on 2/5/25.
//

import Foundation
import SwiftUI
import Combine
import CombineMoya

class AIPlaceListViewModel: ObservableObject {
    
    let container: DIContainer
    
    var cancellables = Set<AnyCancellable>()
        
    // MARK: - AI 코스 생성 결과 화면 Properties
    /// AI 생성 코스 응답
    var courseAIResponse: CourseAICreateResponse?
    
    /// 코스 북마크?
    @Published var isBookmark: Bool = false
        
    // MARK: - Init
    init(container: DIContainer, courseAIResponse: CourseAICreateResponse?) {
        self.container = container
        self.courseAIResponse = courseAIResponse
    }

}

// MARK: - Extension
extension AIPlaceListViewModel {
    
    // MARK: - API 호출 함수
    /// 코스 북마크 API
    func patchCourseBookmark() {
        
        guard let course = courseAIResponse else { return }
        container.useCaseProvider.courseUseCase
            .executePatchCourseBookmark(courseId: course.courseId)
            .tryMap{ responseData -> ResponseData<CourseBookmarkResponse> in
                if !responseData.isSuccess{
                    throw APIError
                        .serverError(
                            message: responseData.message,
                            code: responseData.code
                        )
                }
                
                return responseData
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                
                completion in
                
                switch completion {
                case .finished:
                    print("✅ Patch CourseBookmark Server Completed")
                case .failure(let failure):
                    print("❌ Patch CourseBookmark Failed: \(failure)")
                }
            },receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                if let response = response.result{
                    isBookmark = response.bookmarked
                }
                
            }
            ).store(in: &cancellables)
    }
    
    // MARK: - API 호출 없는 함수
                  
}
