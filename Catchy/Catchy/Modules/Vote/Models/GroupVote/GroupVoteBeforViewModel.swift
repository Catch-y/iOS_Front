//
//  GroupVoteBeforeViewModel.swift
//  Catchy
//
//  Created by 임소은 on 2/6/25.
//

import Foundation
import Combine

class GroupVoteBeforeViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var voteStatus: [VoteCategoryResponse.CategoryDto] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    private let container: DIContainer
    
    // MARK: - Initializer
    init(container: DIContainer) {
        self.container = container
    }
    
    // MARK: - Methods
    func fetchCategories(voteId: Int) {
        isLoading = true
        errorMessage = nil
        
        container.useCaseProvider.categoryVoteUseCase
            .getCategories(voteId: voteId)
            .tryMap { response -> VoteCategoryResponse in
                if !response.isSuccess {
                    throw APIError.serverError(
                        message: response.message,
                        code: response.code
                    )
                }
                // result로부터 데이터 반환
                guard let result = response.result else {
                    throw APIError.serverError(
                        message: "결과가 비어 있습니다.",
                        code: "NO_RESULT"
                    )
                }
                return result
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                if case let .failure(error) = completion {
                    self.errorMessage = "API 호출 실패: \(error.localizedDescription)"
                    print("❌ API 호출 실패: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.voteStatus = response.categories
                print("✅ 카테고리 데이터 로드 성공: \(self.voteStatus)")
            })
            .store(in: &cancellables)
    }
}
