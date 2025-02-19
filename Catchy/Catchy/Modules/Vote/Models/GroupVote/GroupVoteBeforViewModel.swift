//
//  GroupVoteBeforeViewModel.swift
//  Catchy
//
//  Created by 임소은 on 2/6/25.
//

import Foundation
import Combine

class GroupVoteBeforeViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var voteStatusListViewModel: VoteStatusListViewModel
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    // MARK: - Private
    private var cancellables = Set<AnyCancellable>()
    let container: DIContainer
    let voteId: Int
    
    // MARK: - Initializer
    init(container: DIContainer, voteId: Int) {
            self.container = container
            self.voteId = voteId
            self._voteStatusListViewModel = Published(initialValue: VoteStatusListViewModel(container: container)) 
        }
    
    // MARK: - Methods
    func fetchCategories(groupId: Int) {
        isLoading = true
        errorMessage = nil

        container.useCaseProvider.voteUseCase
            .executeGetVoteResults(groupId: groupId, voteId: voteId)
            .receive(on: DispatchQueue.main)  // ✅ 메인 스레드에서 실행
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.isLoading = false
                    self?.errorMessage = "API 호출 실패: \(error.localizedDescription)"
                    print("[❌ API 호출 실패]: \(error.localizedDescription)")
                    self?.loadSampleData()  // ✅ API 실패 시 샘플 데이터 로드
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] responseData in
                if responseData.isSuccess, let categories = responseData.result?.categories {
                    self?.voteStatusListViewModel.voteStatus = categories
                    self?.isLoading = false
                    print("✅ API 데이터 로드 성공: \(categories)")
                } else {
                    self?.errorMessage = "서버 오류 발생"
                    print("[❌ 서버 오류] 메시지: \(responseData.message)")
                }
            })
            .store(in: &cancellables)  // ✅ 메모리 해제 방지
    }


    
    // MARK: - 샘플 데이터 로드
    func loadSampleData() {
        guard let sampleResponse = try? JSONDecoder().decode(
            BaseResponse<VoteResultCategoryResponse>.self,
            from: VoteAPITarget.getVoteResults(groupId: 1, voteId: 1).sampleData
        ) else {
            print("[❌ 오류] 샘플 데이터 디코딩 실패")
            return
        }

        DispatchQueue.main.async {
            if let categories = sampleResponse.result?.categories {
                self.voteStatusListViewModel.voteStatus = categories
                print("[✅ 샘플 데이터 로드 성공] 카테고리 데이터:", categories)
                print("📢 현재 voteStatusListViewModel.voteStatus:", self.voteStatusListViewModel.voteStatus)

                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                  
                }
            } else {
                print("[❌ 오류] 샘플 데이터에 카테고리 없음")
            }
        }
    }

}
