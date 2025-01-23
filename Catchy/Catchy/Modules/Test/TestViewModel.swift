//
//  TestViewModel.swift
//  Catchy
//
//  Created by 정의찬 on 1/23/25.
//

import Foundation
import Combine
import CombineMoya

class TestViewModel: ObservableObject {
    @Published var couseData: GetCourseInfo?
    @Published var isLoading: Bool = false
    
    let container: DIContainer
    var cancellables = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }

}

extension TestViewModel {
    func getCourseData(couseData: GetCourseRequest) {
        
        isLoading = true
        
        container.useCaseProvider.couseUseCase.executeGetCourseInfo(courseData: couseData)
            .tryMap { responseData -> ResponseData<GetCourseInfo> in
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
                    print("✅ Get CouseInfo Server Completed")
                case .failure(let failure):
                    print("❌ Get CourInfo Failed: \(failure)")
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                if let reponse = response.result {
                    self.couseData = reponse
                }
            })
            .store(in: &cancellables)
    }
}
