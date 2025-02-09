//
//  VoteViewModel.swift
//  Catchy
//
//  Created by 임소은 on 1/28/25.
//

import Combine

// MARK: - ViewModel 정의
class VoteViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var groupID: Int // 그룹 ID 저장
    @Published var selectedCategories: [CategoryType] = [] // 선택된 카테고리 저장

    private var cancellables = Set<AnyCancellable>() // Combine 작업 취소를 위한 Set
    private let categoryVoteUseCase: CategoryVoteUseCase // [투표 카테고리] UseCase

    // MARK: - Initializer
    init(container: DIContainer, groupID: Int) {
        self.groupID = groupID
        self.categoryVoteUseCase = container.useCaseProvider.categoryVoteUseCase
    }

    // MARK: - 선택된 카테고리 업데이트
    func updateCategories(with categories: [CategoryType]) {
        self.selectedCategories = categories
        print("선택된 카테고리 업데이트: \(categories)")
    }

    // MARK: - 서버로 카테고리 저장 요청
    func saveCategoriesToServer() {
        categoryVoteUseCase.saveCategories(groupID: groupID, categories: selectedCategories)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("카테고리 저장 성공")
                case .failure(let error):
                    print("카테고리 저장 실패: \(error.localizedDescription)")
                }
            }, receiveValue: { response in
                print("응답 수신: \(response)")
            })
            .store(in: &cancellables)
    }
}
