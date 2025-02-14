//
//  MyReviewsCourseViewModel.swift
//  Catchy
//
//  Created by 권용빈 on 2/14/25.
//

import SwiftUI
import Combine

/// MyCourseReviewsViewModel: 내 코스 리뷰 화면을 위한 ViewModel
class MyCourseReviewsViewModel: ObservableObject {
    
    /// 내 코스 리뷰 조회 Response
    @Published var myCourseReviewsData: MyCourseReviewResponse?
    
    /// 내 리뷰 조회 API 로딩 상태
    @Published var isMyCourseReviewsLoading: Bool = false
    
    /// 내 리뷰 개수
    @Published var reviewCount: Int = 0
    
    let container: DIContainer
    var cancellables = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
}

extension MyCourseReviewsViewModel {
    /// 내 코스 리뷰 조회 API 호출
    func getMyCourseReviews(review: MyCourseReviewRequest) {
        isMyCourseReviewsLoading = true
        
        container.useCaseProvider.myPageUseCase.executeGetMyCourseReviews(review: review)
            .tryMap { responseData -> ResponseData<MyCourseReviewResponse> in
                if !responseData.isSuccess {
                    throw APIError.serverError(message: responseData.message, code: responseData.code)
                }
                return responseData
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.isMyCourseReviewsLoading = false
                
                switch completion {
                case .finished:
                    print("✅ Get My CourseReviews Completed")
                case .failure(let failure):
                    print("❌ Get My CourseReviews Failed: \(failure)")
                }
                
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                if let response = response.result {
                    print("🎯 Parsed Response Data: \(response)")
                    self.myCourseReviewsData = response
                    self.reviewCount = response.reviewCount
                }
            })
            .store(in: &cancellables)
    }
}
