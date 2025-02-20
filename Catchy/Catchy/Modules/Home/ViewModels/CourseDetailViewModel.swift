//
//  CourseViewModel.swift
//  Catchy
//
//  Created by 정의찬 on 2/7/25.
//

import Foundation
import Combine
import CombineMoya

class CourseDetailViewModel: ObservableObject {
    
    @Published var courseDetailResponse: CourseDetailResponse?
    
    @Published var showAlert: Bool = false
    
    @Published var isLoading: Bool = true
    
    @Published var isReviewPresented: Bool = false
    
    var cancellables = Set<AnyCancellable>()

    let courseId: Int
    let container: DIContainer
    
    //MARK: - Init
    
    init(container: DIContainer, courseId: Int) {
        self.container = container
        self.courseId = courseId
    }
    
}

//MARK: - Extension

extension CourseDetailViewModel {
    
    /// 코스 상세 정보 조회 API
    func getCourseDetail() {
        
        isLoading = true
        
        container.useCaseProvider.courseUseCase
            .executeGetCourseDetail(courseId: courseId)
            .tryMap{ responseData -> ResponseData<CourseDetailResponse> in
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
                    print("✅ Get CourseDetail Server Completed")
                case .failure(let failure):
                    print("❌ Get CourseDetail Failed: \(failure)")
                }
            },receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                if let response = response.result{
                    self.courseDetailResponse = response
                }
                
            })
            .store(in: &cancellables)
    }
    
    /// 코스 북마크 API
    func patchCourseBookmark() {
        
        courseDetailResponse?.isBookMarked.toggle()
        
        container.useCaseProvider.courseUseCase
            .executePatchCourseBookmark(courseId: courseId)
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
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("✅ Patch CourseBookmark Server Completed")
                case .failure(let failure):
                    print("❌ Patch CourseBookmark Failed: \(failure)")
                }
            },receiveValue: { response in
                
                if let response = response.result{
                    print("북마크 결과 표시: \(response)")
                }
            })
            .store(in: &cancellables)
    }
}
