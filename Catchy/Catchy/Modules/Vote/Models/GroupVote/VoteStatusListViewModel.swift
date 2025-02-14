import Foundation
import Combine
import Moya

class VoteStatusListViewModel: ObservableObject {
    // MARK: - Properties
    @Published var voteStatus: [CategoryResultData] = []  // ✅ 올바른 타입으로 변경
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    let container: DIContainer
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initializer
    init(container: DIContainer) {
        self.container = container
    }

    // MARK: - Fetch Categories
    func fetchCategories(groupId: Int, voteId: Int) {
        isLoading = true
        errorMessage = nil

        let provider = MoyaProvider<VoteAPITarget>()

        provider.request(.getVoteResults(groupId: groupId, voteId: voteId)) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    do {
                        let decodedResponse = try JSONDecoder().decode(BaseResponse<VoteResultCategoryResponse>.self, from: response.data)
                        if decodedResponse.isSuccess, let categoryResult = decodedResponse.result {
                            self?.voteStatus = categoryResult.categories.map { category in
                                CategoryResultData(category: category.category, count: 0) // ✅ 항상 count = 0
                            }
                            print("✅ 투표 결과 로드 성공 (항상 count 0 적용): \(self?.voteStatus ?? [])")
                        } else {
                            self?.errorMessage = decodedResponse.message
                            print("❌ API 응답 실패: \(decodedResponse.message)")
                            self?.loadSampleData()  // ✅ API 응답 실패 시 샘플 데이터 로드
                        }
                    } catch {
                        self?.errorMessage = "디코딩 오류: \(error.localizedDescription)"
                        print("❌ 디코딩 오류: \(error.localizedDescription)")
                        self?.loadSampleData()  // ✅ 디코딩 오류 시 샘플 데이터 로드
                    }
                case .failure(let error):
                    self?.errorMessage = "네트워크 오류: \(error.localizedDescription)"
                    print("❌ 네트워크 오류: \(error.localizedDescription)")
                    self?.loadSampleData()  // ✅ 네트워크 오류 시 샘플 데이터 로드
                }
            }
        }
    }

    // MARK: - 샘플 데이터 로드
    private func loadSampleData() {
        guard let sampleResponse = try? JSONDecoder().decode(
            BaseResponse<VoteResultCategoryResponse>.self,
            from: VoteAPITarget.getVoteResults(groupId: 1, voteId: 1).sampleData
        ) else {
            DispatchQueue.main.async {
                self.errorMessage = "샘플 데이터 디코딩 실패"
                print("❌ 샘플 데이터 디코딩 실패")
            }
            return
        }

        DispatchQueue.main.async {
            self.voteStatus = sampleResponse.result?.categories.map { category in
                CategoryResultData(category: category.category, count: 0) // ✅ 항상 count = 0
            } ?? []

            print("✅ 샘플 데이터 로드 성공 (투표 전 count 0 적용): \(self.voteStatus)")
        }
    }

}

