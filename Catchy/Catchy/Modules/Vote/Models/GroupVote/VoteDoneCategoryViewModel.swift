//
//  VoteDoneCategoryViewModel.swift
//  Catchy
//
//  Created by 임소은 on 2/9/25.
//

import Foundation
import Combine

final class VoteDoneCategoryViewModel: ObservableObject {
    @Published var categories: [VoteCategoryResponse.CategoryDto] = [] // 카테고리 데이터
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let container: DIContainer
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initializer
    init(container: DIContainer) {
        self.container = container
    }

    // MARK: - API 호출
    func fetchCategories(voteId: Int) {
        isLoading = true
        container.useCaseProvider.categoryVoteUseCase
            .getCategories(voteId: voteId)
            .tryMap { response -> [VoteCategoryResponse.CategoryDto] in
                guard let categories = response.result?.categories else {
                    throw APIError.serverError(message: response.message, code: response.code)
                }
                return categories
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] categories in
                self?.categories = categories
            })
            .store(in: &cancellables)
    }
}
