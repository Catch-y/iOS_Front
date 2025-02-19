//
//  VoteViewModel.swift
//  Catchy
//
//  Created by 임소은 on 1/28/25.
//

import Combine
import Foundation

// MARK: - ViewModel 정의
class VoteViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var groupId: Int // 그룹 ID 저장
    @Published var selectedCategories: [String] = [] // 선택된 카테고리 저장 (CategoryType → String)
    @Published var errorMessage: String? = nil // 오류 메시지
    private var cancellables = Set<AnyCancellable>() // Combine 작업 취소를 위한 Set
    private let voteUseCase: VoteUseCase // [투표 카테고리] UseCase

    // MARK: - Initializer
    init(container: DIContainer, groupId: Int) {
        self.groupId = groupId
        self.voteUseCase = container.useCaseProvider.voteUseCase
    }

    // MARK: - 선택된 카테고리 업데이트
    func updateCategories(with categories: [String]) {
        self.selectedCategories = categories
    }

   // MARK: - 서버로 카테고리 저장 요청
    func saveCategoriesToServer(voteId: Int) {
        guard !selectedCategories.isEmpty else {
            print("[오류] 선택된 카테고리가 없습니다.")
            return
        }
        
        let request = VoteCategoryRequest(categories: selectedCategories)

        voteUseCase.executePostCategoryVote(voteId: voteId, categoryVoteRequest: request)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    print("[API 요청 실패] \(error.localizedDescription)")
                    self.errorMessage = "서버 응답 없음, 샘플 데이터 로드"
                    self.loadSampleData() // 샘플 데이터 로드
                case .finished:
                    break
                }
            }, receiveValue: { response in
                print("[서버 응답] \(response)")
            })
            .store(in: &cancellables)
    }



    // MARK: - 샘플 데이터 로드
    private func loadSampleData() {
        guard let sampleResponse = try? JSONDecoder().decode(
            ResponseData<VoteResultCategoryResponse>.self,
            from: VoteAPITarget.getVoteResults(groupId: 1, voteId: 1).sampleData
        ) else {
            print("[샘플 데이터 디코딩 실패]")
            return
        }

        DispatchQueue.main.async {
            self.selectedCategories = sampleResponse.result?.categories.map { $0.category } ?? []
            print("[샘플 데이터 적용] \(self.selectedCategories)")
        }
    }

}
