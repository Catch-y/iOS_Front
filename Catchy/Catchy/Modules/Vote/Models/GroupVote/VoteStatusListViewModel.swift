//
//  VoteBeforeStatusListViewModel.swift
//  Catchy
//
//  Created by 임소은 on 2/7/25.
//

import Foundation
import Combine

class VoteStatusListViewModel: ObservableObject {

    // MARK: - Properties
    @Published var voteStatus: [VoteCategoryResponse.CategoryDto] = []  // 카테고리 배열
    @Published var selectedCategories: [CategoryType] = [] // 선택된 카테고리 배열
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private var cancellables = Set<AnyCancellable>()
    let container: DIContainer // 의존성 주입을 위한 DIContainer 사용

    // MARK: - Initializer
    init(container: DIContainer) {
        self.container = container
    }

    // MARK: - Methods

    /// 카테고리 데이터를 가져오는 메서드
    func fetchCategories(voteId: Int) {
        isLoading = true
        errorMessage = nil

        container.useCaseProvider.categoryVoteUseCase
            .getCategories(voteId: voteId)
            .tryMap { response -> [VoteCategoryResponse.CategoryDto] in
                // `result`에서 `categories`를 반환
                guard let result = response.result else {
                    throw APIError.serverError(message: response.message, code: response.code)
                }
                return result.categories
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                if case let .failure(error) = completion {
                    self.errorMessage = "API 호출 실패: \(error.localizedDescription)"
                    print("❌ API 호출 실패: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] categories in
                guard let self = self else { return }
                // 카테고리 데이터 업데이트
                self.voteStatus = categories
                print("✅ 카테고리 데이터 로드 성공: \(self.voteStatus)")
            })
            .store(in: &cancellables)
    }

    /// 선택된 카테고리를 업데이트하는 메서드
    func updateSelectedCategories(_ categories: [CategoryType]) {
        self.selectedCategories = categories
        print("✅ 선택된 카테고리 업데이트: \(selectedCategories)")
    }
}
