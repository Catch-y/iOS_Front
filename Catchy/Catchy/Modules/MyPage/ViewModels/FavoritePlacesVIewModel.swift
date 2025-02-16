//
//  FavoritePlacesVIewModel.swift
//  Catchy
//
//  Created by 권용빈 on 2/5/25.
//

import SwiftUI
import Combine

class FavoritePlacesViewModel: ObservableObject {
    
    let container: DIContainer
    
    var cancellables = Set<AnyCancellable>()
    
    @Published var myPlaceResponse: MyPlaceResponse?
    @Published var isLoading: Bool = false
    
    // MARK: - 장소 평점 화면 Properties
    /// 장소 평점 화면 상태
    @Published var isPresented: Bool = false
    
    /// 평점을 보고자 하는 장소 ID
    var selectedPlaceId: Int? = nil
    
    // MARK: - Init
    
    init(container: DIContainer) {
        self.container = container
    }
}
extension FavoritePlacesViewModel {
    // MARK: - API 호출 함수
    /// 좋아요한 장소 무한 스크롤
    func getMyPlaceList(pageSize: Int, lastPlaceId: Int? = nil)
    {
        isLoading = true
        
        container.useCaseProvider.placeCourseUseCase
            .executeGetMyPlaceList(pageSize: pageSize, lastPlaceId: lastPlaceId)
            .tryMap{ responseData -> ResponseData<MyPlaceResponse> in
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
                    print("✅ Get MyPlaceList Server Completed")
                case .failure(let failure):
                    print("❌ Get MyPlaceList Failed: \(failure)")
                }
            },receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                if let response = response.result{
                    self.myPlaceResponse = response
                }
                
            })
            .store(in: &cancellables)
        
    }
    
    /// 장소 평점 화면을 보여줍니다
    /// - Parameter placeId: 평점을 보고자 하는 장소 ID
    func showReview(placeId: Int) {
        self.selectedPlaceId = placeId
        self.isPresented.toggle()
    }
}
