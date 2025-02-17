//
//  CourseReviewViewModel.swift
//  Catchy
//
//  Created by 권용빈 on 2/17/25.
//

import Foundation
import Combine

class CourseReviewViewModel: ObservableObject {
    
    @Published var courseReviewData: CourseReviewInfoResponse?
    @Published var isLoading: Bool = false
    
    let container: DIContainer
    var cancellables = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
}

extension CourseReviewViewModel {
    func getCourseReviewData(courseId: Int, lastReviewId: Int? = nil) {
        isLoading = true

        container.useCaseProvider.reviewUseCase
            .executeCourseReviewResponse(courseId: courseId, pageSize: 10, lastReviewId: lastReviewId)
            .tryMap { responseData -> ResponseData<CourseReviewInfoResponse> in
                if !responseData.isSuccess {
                    throw APIError.serverError(message: responseData.message, code: responseData.code)
                }
                return responseData
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                switch completion {
                case .finished:
                    print("✅ Get Course Review Server Completed")
                case .failure(let failure):
                    print("❌ Get Course Review Failed: \(failure)")
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                if let result = response.result {
                    print("🎯 Parsed Course Review Data: \(result)")
                    self.courseReviewData = result
                }
            })
            .store(in: &cancellables)
    }
}
