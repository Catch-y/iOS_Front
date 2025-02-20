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
    
    /// 내 선호 장소 배열 데이터
    @Published var myPlaceResponse: [MyPageLikePlaceData] = []
    
    /// 내 선호 장소 조회 API 로딩 중?
    @Published var isMyPlaceLoading: Bool = false

    /// 현재까지 불러온 마지막 리뷰의 ID
    private var lastPlaceId: Int? = nil
    
    /// 마지막 페이지?
    var isLastPage: Bool = false
    
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
    func getMyPlaceList()
    {
        guard !isMyPlaceLoading, !isLastPage else { return }
                
        if myPlaceResponse.isEmpty {
            isMyPlaceLoading = true
        }
        container.useCaseProvider.placeCourseUseCase
            .executeGetMyPlaceList(pageSize: 10, lastPlaceId: lastPlaceId)
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
                self.isMyPlaceLoading = false
                
                switch completion {
                case .finished:
                    print("✅ Get MyPlaceList Server Completed")
                case .failure(let failure):
                    print("❌ Get MyPlaceList Failed: \(failure)")
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                if let result = response.result {
                    if result.content.isEmpty {
                        self.myPlaceResponse = []
                    } else {
                        self.myPlaceResponse.append(contentsOf: result.content)
                    }
                    
                    self.isLastPage = result.last
                    
                    if !self.isLastPage, let lastItem = self.myPlaceResponse.last {
                        self.lastPlaceId = lastItem.placeId
                    }
                }
            })
            .store(in: &cancellables)
        
    }
}
