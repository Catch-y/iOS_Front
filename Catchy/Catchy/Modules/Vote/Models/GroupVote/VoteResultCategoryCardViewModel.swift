//
//  VoteResultCategoryCardViewModel.swift
//  Catchy
//
//  Created by 임소은 on 2/10/25.
//

import Foundation
import SwiftUI
import Moya

class VoteResultCategoryCardViewModel: ObservableObject {
    @Published var isBookmarked: Bool = false
    @Published var places: [PlaceResponse] = []

    let provider: MoyaProvider<VoteResultPlaceAPITarget>
    let groupId: Int
    let category: String

    init(groupId: Int, category: String, useSampleData: Bool = false) {
        self.groupId = groupId
        self.category = category

        if useSampleData {
            self.provider = MoyaProvider<VoteResultPlaceAPITarget>(stubClosure: { _ in .immediate })
            loadSampleData()
        } else {
            self.provider = MoyaProvider<VoteResultPlaceAPITarget>()
            fetchPlaces()
        }
    }

    func fetchPlaces() {
        let request = VoteResultPlaceRequest(groupId: groupId, category: category)

        provider.request(.getPlacesByCategory(request: request)) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedResponse = try JSONDecoder().decode(VoteResultPlaceResponse.self, from: response.data)
                    DispatchQueue.main.async {
                        self.places = decodedResponse.places
                        print("[데이터 로드 성공] 실제 API에서 \(self.places.count)개의 장소를 가져왔습니다.")
                    }
                } catch {
                    print("[오류] 데이터 디코딩 실패:", error)
                }
            case .failure(let error):
                print("[오류] API 요청 실패:", error)
            }
        }
    }

    private var isSampleDataLoaded = false // 중복 실행 방지 플래그

    func loadSampleData() {
        // 이미 샘플 데이터를 로드했다면 실행하지 않음
        guard !isSampleDataLoaded else { return }
        isSampleDataLoaded = true // 플래그 설정

        let sampleTarget = VoteResultPlaceAPITarget.getPlacesByCategory(
            request: VoteResultPlaceRequest(groupId: 1, category: "카페")
        )

        do {
            let response = try JSONDecoder().decode(VoteResultPlaceResponse.self, from: sampleTarget.sampleData)
            DispatchQueue.main.async {
                self.places = response.places
                print("✅ 샘플 데이터 로드 성공 !: \(response)")
            }
        } catch {
            print("❌ 샘플 데이터 디코딩 실패: \(error)")
        }
    }



    func toggleBookmark() {
        isBookmarked.toggle()
    }
}
