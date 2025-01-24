//
//  TestViewModel.swift
//  Catchy
//
//  Created by LEE on 1/23/25.
//

import Foundation
import Combine
import CombineMoya



class TestViewModel: ObservableObject {
    @Published var courseData: GetCourseInfoResponse?
    
    // 여러 로딩이 필요하면 ~~Loading으로 만들어라.
    @Published var isLoading: Bool = false
    
    let container: DIContainer
    var cancellables = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
}


extension TestViewModel {
    
    func getCourseData(courseData: GetCourseInfoRequest) {
        
        isLoading = true
        
        container.useCaseProvider.courseUseCase
            .executeGetCourseInfo(courseData: courseData)
            .tryMap { responseData -> ResponseData<GetCourseInfoResponse> in
                if !responseData.isSuccess {
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
                    print("✅ Get CourseInfo Server Completed")
                case .failure(let failure):
                    print("❌ Get CourseInfo Failed: \(failure)")
                }
            },receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                if let response = response.result{
                    self.courseData = response
                }
                
            })
            .store(in: &cancellables)
    }
    
}
