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
    
    let container: DIContainer
    
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - 장소 카테고리 선택 화면 Properties
    /// 선택된 카테고리
    @Published var selectedCategory: [CategoryType: String] = [:]

    /// 현재 카테고리를 등록하고자 하는 장소
    let placeId: Int
    
    /// 장소 카테고리 선택화면 샅애
    @Binding var isPresented: Bool
    
    /// 카테고리 등록이 완료되었는가?
    @Published var hasRegister: Bool = false
    
    // MARK: - Init
    init(container: DIContainer, placeId: Int, isPresented: Binding<Bool>) {
        self.container = container
        self.placeId = placeId
        self._isPresented = isPresented
    }
}

// MARK: - Extension
extension PlaceCategoryRegisterViewModel {
    
    
    // MARK: - API 요청 함수
    /// 장소 카테고리 선택 API
    func postPlaceCategoryRegister() {
        
        guard let (bigCategory, smallCategory) = selectedCategory.first else { return }
        
        let request = PlaceCategoryRegisterRequest(bigCategory: bigCategory, smallCategory: smallCategory)
        
        container.useCaseProvider.courseUseCase.executePostPlaceCategoryRegister(placeId: placeId, place: request)
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
            .sink(receiveCompletion: { [weak self]
                completion in
                
                guard let self = self else { return }
                
                self.hasRegister = true
                
                switch completion {
                case .finished:
                    print("✅ Post PlaceCategoryRegister Server Completed")
                    
                case .failure(let failure):
                    print("❌ Post PlaceCategoryRegister Failed: \(failure)")
                }
            },receiveValue: { response in
                
            })
            .store(in: &cancellables)
        }
    
    // MARK: - API 요청 없는 함수
    /// 장소 카테고리 선택 화면을 닫습니다.
    func close() {
        isPresented.toggle()
    }
}
