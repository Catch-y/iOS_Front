//
//  LocationSelectViewModel.swift
//  Catchy
//
//  Created by 임소은 on 2/12/25.
//

import SwiftUI
import Combine
import Moya

class LocationSelectViewModel: ObservableObject {
    @Published var selectedLocation: String? // 선택된 지역
    @Published var locations: [String] = [] // 서버에서 받아온 지역 목록

    private let provider: MoyaProvider<ProvinceAPITarget>
    private let container: DIContainer
    private var cancellables = Set<AnyCancellable>()
    
    private var isFetching = false // 중복 실행 방지 변수

    init(container: DIContainer, provider: MoyaProvider<ProvinceAPITarget> = MoyaProvider<ProvinceAPITarget>()) {
        self.container = container
        self.provider = provider
        fetchLocations() // 뷰모델 초기화 시 지역 목록 가져오기
    }

    /// 서버에서 시/도 지역 목록 가져오기 (서버 실패 시 샘플 데이터 유지)
    func fetchLocations() {
        guard !isFetching else {
            print("⚠️ fetchLocations() 중복 실행 방지됨")
            return
        }

        isFetching = true // 실행 중 상태로 설정
       

        // 1️⃣ 기본 샘플 데이터 설정 (네트워크 요청 실패 대비)
        DispatchQueue.main.async {
            if self.locations.isEmpty {
                print("🟢 샘플 데이터 적용됨")
                self.locations = [
                    "서울시", "경기도", "인천", "울산", "부산", "대구",
                    "광주", "대전", "세종시", "강원도", "충청북도", "충청남도",
                    "전북", "전남", "경북", "경남", "제주도"
                ]
            }
        }

        // 2️⃣ 서버에 액세스 토큰 요청
        provider.request(.getAccessToken) { [weak self] result in
            DispatchQueue.main.async {
                self?.isFetching = false // 네트워크 응답 후 다시 실행 가능하게 변경
            }

            switch result {
            case .success(let response):
                if let accessToken = self?.parseAccessToken(response.data) {
                    self?.fetchProvinces(with: accessToken)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("🔴 서버 연결 실패 → 샘플 데이터 유지 | 오류: \(error.localizedDescription)")
                }
            }
        }
    }

    /// 서버에서 시/도 데이터를 가져와 locations에 저장
    private func fetchProvinces(with accessToken: String) {
        provider.request(.getProvinces(accessToken: accessToken)) { [weak self] result in
            DispatchQueue.main.async {
                self?.isFetching = false // 실행 종료
            }

            switch result {
            case .success(let response):
                do {
                    let decodedResponse = try JSONDecoder().decode(ProvinceResponse.self, from: response.data)
                    DispatchQueue.main.async {
                        self?.locations = decodedResponse.result.map { $0.addrName } // 실제 데이터 업데이트
                        print("🟢 Province 데이터 수신 성공 → UI 업데이트")
                    }
                } catch {
                    DispatchQueue.main.async {
                        print("🔴 JSON 디코딩 실패 → 샘플 데이터 유지 | 오류: \(error.localizedDescription)")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("🔴 Province API 요청 실패 → 샘플 데이터 유지 | 오류: \(error.localizedDescription)")
                }
            }
        }
    }

    /// AccessToken을 파싱하는 함수
    private func parseAccessToken(_ data: Data) -> String? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            let token = json?["accessToken"] as? String
            print("🟢 Access Token 파싱 성공: \(token ?? "토큰 없음")")
            return token
        } catch {
            print("🔴 Access Token 파싱 실패 | 오류: \(error.localizedDescription)")
            return nil
        }
    }
}
