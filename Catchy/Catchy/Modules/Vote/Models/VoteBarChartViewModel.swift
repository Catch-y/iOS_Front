//
//  GroupVoteStartViewModel.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//

import SwiftUI
import Combine
import Moya

class VoteBarChartViewModel: ObservableObject {
    
    // MARK: - Nested Model
    struct VoteOption: Identifiable {
        let id = UUID()
        let name: String
        let count: Int
        let type: CategoryType
        
        var color: Color {
            return type.setColor()
        }
    }
    
    // MARK: - Properties
    @Published var options: [VoteOption] = []
    private var cancellables = Set<AnyCancellable>()
    private let provider = MoyaProvider<VoteResultCategoryAPITarget>(stubClosure: MoyaProvider.immediatelyStub) // 샘플 데이터 사용
    
    // MARK: - Initializer
    init(groupId: Int, voteId: Int) {
        fetchDataFromServer(groupId: groupId, voteId: voteId)
    }

    // MARK: - Methods
    func fetchDataFromServer(groupId: Int, voteId: Int) {
        provider.request(.getVoteResultCategory(groupId: groupId, voteId: voteId)) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(ResponseData<VoteResultCategoryResponse>.self, from: response.data)

                    print("✅ API 응답 데이터 확인: \(decodedData)")
                    
                    DispatchQueue.main.async {
                        if let categories = decodedData.result?.categories, !categories.isEmpty {
                            self.options = categories.map { category in
                                let type = CategoryType(rawValue: category.category) ?? .CAFE
                                let option = VoteOption(
                                    name: category.category.isEmpty ? "Unknown" : category.category, // 빈 값 방지
                                    count: category.count,
                                    type: type
                                )
                                return option
                            }
                        } else {
                            print("⚠️ API 응답은 성공했지만 카테고리 데이터가 없음!")
                            self.loadSampleData() // 강제 샘플 데이터 로드
                        }
                    }
                } catch {
                    print("❌ JSON 디코딩 실패: \(error)")
                }
            case .failure(let error):
                print("❌ API 요청 실패: \(error.localizedDescription)")
                self.loadSampleData()
            }
        }
    }



    // MARK: - 샘플 데이터 로드
    func loadSampleData() {
        provider.request(.getVoteResultCategory(groupId: 1, voteId: 1)) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(ResponseData<VoteResultCategoryResponse>.self, from: response.data)
                    
                    if let categories = decodedData.result?.categories {
                        DispatchQueue.main.async {
                            self.options = categories.map { category in
                                let type = CategoryType(rawValue: category.category) ?? .CAFE
                                return VoteOption(
                                    name: category.category.isEmpty ? "Unknown" : category.category, //  빈 값 방지
                                    count: category.count,
                                    type: type
                                )
                            }
                        }
                    }
                } catch {
                    print("❌ 샘플 데이터 디코딩 실패: \(error)")
                }
            case .failure(let error):
                print("❌ 샘플 데이터 요청 실패: \(error.localizedDescription)")
            }
        }
    }
}

