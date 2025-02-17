//
//  SubLocationSelectViewModel.swift
//  Catchy
//
//  Created by 임소은 on 2/12/25.
//

import SwiftUI
import Combine
import Moya

class SubLocationSelectViewModel: ObservableObject {
    @Published var selectedSubLocation: String? // 선택된 하위 지역
    @Published var sublocations: [String] = [] // 서버에서 받아온 하위 지역 목록

    private let provider: MoyaProvider<ProvinceAPITarget>
    private let container: DIContainer
    private var cancellables = Set<AnyCancellable>()
    
    private var isFetching = false // 중복 실행 방지 변수

    init(container: DIContainer, provider: MoyaProvider<ProvinceAPITarget> = MoyaProvider<ProvinceAPITarget>()) {
        self.container = container
        self.provider = provider
    }

    /// 서버에서 선택된 시/도의 하위 지역 목록 가져오기 (서버 실패 시 샘플 데이터 유지)
    func fetchSubLocations(for provinceCode: String) {
        guard !isFetching else {
            print("⚠️ fetchSubLocations() 중복 실행 방지됨")
            return
        }

        isFetching = true // 실행 중 상태로 설정

        // 1️⃣ 기본 샘플 데이터 설정 (네트워크 요청 실패 대비)
        DispatchQueue.main.async {
            if self.sublocations.isEmpty {
                print("🟢 샘플 데이터 적용됨")
                self.sublocations = [
                    "강남구", "종로구", "중구",
                    "용산구", "성동구", "광진구",
                    "동대문구", "중랑구", "성북구",
                    "강북구", "도봉구", "노원구",
                    "은평구", "서대문구", "마포구",
                    "양천구", "강서구", "구로구",
                    "금천구", "영등포구", "동작구",
                    "관악구", "서초구", "송파구",
                    "강동구"
                ]
            }
        }

        // 2️⃣ 서버에 하위 지역 요청
        provider.request(.getDistricts(accessToken: "TEST_ACCESS_TOKEN", provinceCode: provinceCode)) { [weak self] result in
            DispatchQueue.main.async {
                self?.isFetching = false // 네트워크 응답 후 다시 실행 가능하게 변경
            }

            switch result {
            case .success(let response):
                do {
                    let decodedResponse = try JSONDecoder().decode(ProvinceResponse.self, from: response.data)
                    DispatchQueue.main.async {
                        self?.sublocations = decodedResponse.result.map { $0.addrName } // 실제 데이터 업데이트
                        print("🟢 하위 지역 데이터 수신 성공 → UI 업데이트")
                    }
                } catch {
                    DispatchQueue.main.async {
                        print("🔴 JSON 디코딩 실패 → 샘플 데이터 유지 | 오류: \(error.localizedDescription)")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("🔴 하위 지역 API 요청 실패 → 샘플 데이터 유지 | 오류: \(error.localizedDescription)")
                }
            }
        }
    }
}
