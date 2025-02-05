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

class AICourseCreateViewModel: ObservableObject {
    
    let container: DIContainer
    
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - AI 코스 생성 로딩화면 Properties
    /// 애니메이션 시간
    let duration: TimeInterval = 0.75

    @Published var showRedPin = false
    @Published var showYellowPin = false
    @Published var showPurplePin = false
    @Published var showBluePin = false
    
    @Published var floatingRedPin = false
    @Published var floatingYellowPin = false
    @Published var floatingPurplePin = false
    @Published var floatingBluePin = false
    
    /// AI 생성 응답 기다리는 중?
    @Published var isLoading = true
    
    /// AI 생성 코스 응답
    @Published var courseAIResponse: CourseAICreateResponse?
    
    // MARK: - Init
    init(container: DIContainer) {
        self.container = container
    }

}


extension AICourseCreateViewModel {
    
    // MARK: - API 요청 함수
    /// 코스 생성(AI) API
    func postCreateCourseAI() {
                
        container.useCaseProvider.courseUseCase
            .executePostCreateCourseAI()
            .tryMap{ responseData -> ResponseData<CourseAICreateResponse> in
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
                [weak self] completion in
                guard let self = self else { return }
                
                self.isLoading = false
                
                switch completion {
                case .finished:
                    print("✅ Post CreateAICourse Server Completed")
                case .failure(let failure):
                    print("❌ Post CreateAICourse Failed: \(failure)")
                }
            },receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                if let response = response.result{
                    self.courseAIResponse = response
                }
                
            }
            ).store(in: &cancellables)
    }
                  
}
