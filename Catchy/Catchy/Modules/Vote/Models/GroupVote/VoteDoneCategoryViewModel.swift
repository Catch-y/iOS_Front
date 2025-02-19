//
//  VoteDoneCategoryViewModel.swift
//  Catchy
//
//  Created by 임소은 on 2/9/25.
//

import Foundation
import Combine

final class VoteDoneCategoryViewModel: ObservableObject {
    @Published var categories: [CategoryResultData] = [] // CategoryResultData 사용
    @Published var groupLocation: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let container: DIContainer
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initializer
    init(container: DIContainer) {
        self.container = container
    }

    // MARK: - API 호출
    func fetchCategories(groupId: Int, voteId: Int) {
        isLoading = true
        errorMessage = nil

        container.useCaseProvider.voteUseCase
            .executeGetVoteResults(groupId: groupId, voteId: voteId)
            .tryMap { response -> VoteResultCategoryResponse in  // ✅ 반환 타입 확인!
                guard response.isSuccess, let result = response.result else {
                    throw APIError.serverError(message: response.message, code: response.code)
                }
                return result // ✅ 전체 응답을 반환
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                    print("❌ API 요청 실패: \(error.localizedDescription)")
                    self?.loadSampleData() // API 실패 시 샘플 데이터 활용
                }
            }, receiveValue: { [weak self] result in
                print("📌 전체 응답 데이터: \(result)") // ✅ 전체 응답 확인
                
                self?.groupLocation = result.groupLocation ?? "위치 정보 없음" // ✅ 기본값 설정
                self?.categories = result.categories

                print("📌 Group Location 저장됨: \(self?.groupLocation ?? "없음")") // ✅ 최종 값 확인
            }

)
            .store(in: &cancellables)
    }


    // MARK: - 샘플 데이터 로드
    private func loadSampleData() {
        let sampleData = VoteAPITarget.getVoteResults(groupId: 1, voteId: 1).sampleData // ✅ 기존대로 getVoteResults 사용

        do {
            let sampleResponse = try JSONDecoder().decode(
                ResponseData<VoteResultCategoryResponse>.self, // ✅ 올바른 응답 타입
                from: sampleData
            )

            DispatchQueue.main.async {
                self.groupLocation = sampleResponse.result?.groupLocation ?? "위치 정보 없음" // ✅ groupLocation 추가!
                self.categories = sampleResponse.result?.categories ?? [] // ✅ categories 로드

                if self.categories.isEmpty {
                    print("⚠️ 샘플 데이터에 categories가 비어 있습니다.")
                } else {
                    print("✅ 샘플 데이터 로드 성공: \(self.categories.count)개의 카테고리")
                    print("📌 샘플 데이터 Group Location: \(self.groupLocation)") // ✅ groupLocation 확인 로그 추가
                }
            }
        } catch {
            print("❌ 샘플 데이터 디코딩 실패: \(error.localizedDescription)")
            
            if let jsonString = String(data: sampleData, encoding: .utf8) {
                print("📌 샘플 데이터 원본: \(jsonString)")
            }
        }
    }

}
