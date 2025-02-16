//
//  VoteResultCategoryCardViewModel.swift
//  Catchy
//
//  Created by 임소은 on 2/10/25.
//

import Foundation
import SwiftUI
import Combine
import Moya

class VoteResultCategoryCardViewModel: ObservableObject {
    @Published var isBookmarked: Bool = false
    @Published var places: [PlaceResponse] = []
    @Published var errorMessage: String?

    private let provider = MoyaProvider<VoteAPITarget>()
    private var cancellables = Set<AnyCancellable>()
    private let groupId: Int
    let category: String

    init(groupId: Int, category: String, useSampleData: Bool = false) {
        self.groupId = groupId
        self.category = category

        if useSampleData {
            loadSampleData()
        } else {
            fetchPlaces()
        }
    }

    // MARK: - API 호출
    func fetchPlaces() {
        provider.requestPublisher(.getCategoryPlaces(groupId: groupId, category: category))
            .map(ResponseData<[PlaceResponse]>.self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    self.errorMessage = "API 요청 실패: \(error.localizedDescription)"
                    print("[오류] API 요청 실패:", error.localizedDescription)
                    self.loadSampleData()
                }
            }, receiveValue: { responseData in
                if responseData.isSuccess, let result = responseData.result {
                    self.places = result
                    print("[데이터 로드 성공] API에서 \(self.places.count)개의 장소를 가져왔습니다.")
                } else {
                    self.errorMessage = responseData.message
                    self.loadSampleData()
                }
            })
            .store(in: &cancellables)
    }

    // MARK: - 샘플 데이터 로드
    private func loadSampleData() {
        guard let sampleResponse = try? JSONDecoder().decode(
            ResponseData<VoteResultPlaceResponse>.self,
            from: VoteAPITarget.getCategoryPlaces(groupId: 1, category: "카페").sampleData
        ) else {
            DispatchQueue.main.async {
                self.errorMessage = "샘플 데이터 디코딩 실패"
                print("[오류] 샘플 데이터 디코딩 실패")
            }
            return
        }

        DispatchQueue.main.async {
            self.places = sampleResponse.result?.places ?? []
            print("[샘플 데이터 로드 성공] \(self.places.count)개의 장소를 불러왔습니다.")
        }
    }

    // MARK: - 북마크 토글
    func toggleBookmark() {
        isBookmarked.toggle()
    }
}
