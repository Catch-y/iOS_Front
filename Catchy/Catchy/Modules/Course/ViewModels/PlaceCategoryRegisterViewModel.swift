//
//  PlaceCategoryRegisterViewModel.swift
//  Catchy
//
//  Created by LEE on 2/14/25.
//

import Foundation
import SwiftUI
import Combine
import CombineMoya

class PlaceCategoryRegisterViewModel: ObservableObject {
    
    @Published var selectedCategory: [CategoryType: String] = [:]

    @Binding var placeSearchResponseData: PlaceSearchResponseData
    
    @Binding var isPresented: Bool
    
    let container: DIContainer
    
    var cancellables = Set<AnyCancellable>()
    
    init(container: DIContainer, placeSearchResponseData: Binding<PlaceSearchResponseData>, isPresented: Binding<Bool>) {
        self.container = container
        self._placeSearchResponseData = placeSearchResponseData
        self._isPresented = isPresented
    }
}


extension PlaceCategoryRegisterViewModel {
    
    
    // MARK: - API 요청 함수
    /// 장소 카테고리 선택 API
    func postPlaceCategoryRegister() {
        
        guard let (bigCategory, smallCategory) = selectedCategory.first else { return }
        
        let request = PlaceCategoryRegisterRequest(placeId: placeSearchResponseData.placeId, bigCategory: bigCategory, smallCategory: smallCategory)
        
        container.useCaseProvider.courseUseCase.executePostPlaceCategoryRegister(place: request)
            .tryMap {
                responseData ->
                ResponseData<PlaceCategoryRegisterResponse> in
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
                completion in

                switch completion {
                case .finished:
                    print("✅ Post PlaceCategoryRegister Server Completed")
                case .failure(let failure):
                    print("❌ Post PlaceCategoryRegister Failed: \(failure)")
                }
            },receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.placeSearchResponseData.category = bigCategory
                self.close()
            })
            .store(in: &cancellables)
        }
    
    // MARK: - API 요청 없는 함수
    /// 장소 카테고리 선택 화면을 닫습니다.
    func close() {
        isPresented.toggle()
    }
}
