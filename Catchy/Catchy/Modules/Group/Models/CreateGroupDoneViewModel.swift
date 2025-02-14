//
//  CreateGroupDoneViewModel.swift
//  Catchy
//
//  Created by 임소은 on 2/11/25.
//

import SwiftUI
import Combine
import Moya



@MainActor
final class CreateGroupDoneViewModel: ObservableObject {
    // MARK: - Published
    @Published var groupName: String = "그룹 이름 없음"
    @Published var groupLocation: String = "위치 없음"
    @Published var groupDate: String = "날짜 없음"
    @Published var inviteCode: String
    @Published var backgroundImage: UIImage?
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    let container: DIContainer
    private let provider = MoyaProvider<GroupAPITarget>()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    /// inviteCode: 기본값 ""로, View에서 직접 넘길 수도/안 넘길 수도 있게 처리
    init(container: DIContainer, inviteCode: String = "") {
        self.container = container
        self.inviteCode = inviteCode
    }
    
    // MARK: - loadGroupData
    func loadGroupData() async {
        print("🟢 loadGroupData() 실행됨") // ✅ 실행 여부 확인

        guard !inviteCode.isEmpty else {
            self.errorMessage = "초대 코드가 없습니다."
            print("⚠️ 초대 코드 없음 → 샘플 데이터 로드 실행") 
            loadSampleData()
            return
        }


        self.isLoading = true
        defer { self.isLoading = false }

        do {
            print("🚀 API 요청 시작: \(inviteCode)") // ✅ API 요청 직전 로그

            let response = try await withCheckedThrowingContinuation { continuation in
                provider.request(.getGroupInvite(inviteCode: inviteCode)) { result in
                    print("✅ API 요청 완료, 응답 수신") // ✅ 응답 받았는지 확인

                    switch result {
                    case .success(let moyaResponse):
                        print("📌 API 응답 데이터: \(String(data: moyaResponse.data, encoding: .utf8) ?? "데이터 없음")")
                        continuation.resume(returning: moyaResponse)
                    case .failure(let error):
                        print("❌ API 요청 실패: \(error.localizedDescription)")
                        continuation.resume(throwing: error)
                    }
                }
            }

            print("✅ API 응답 처리 시작") // ✅ 응답 처리 시작

            let decoded = try JSONDecoder().decode(BaseResponseGroupInviteResult.self, from: response.data)
            print("📌 디코딩된 응답 데이터: \(decoded)")

            if decoded.isSuccess {
                updateGroupInfo(with: decoded.result)
            } else {
                self.errorMessage = decoded.message
                print("❌ API 실패: \(decoded.message)")
                loadSampleData() //  샘플 데이터 로드!
            }
            
        } catch {
            self.errorMessage = "❌ API 요청 실패: \(error.localizedDescription)"
            print("❌ API 요청 실패: \(error.localizedDescription)")
            loadSampleData() //  API 실패 시 샘플 데이터 로드!
        }
    }



    // MARK: - 그룹정보 업데이트
    private func updateGroupInfo(with group: GroupInviteResponse) {
        self.groupName = group.groupName
        self.groupLocation = group.groupLocation.isEmpty ? "위치 없음" : group.groupLocation
        self.groupDate = formatDate(group.promiseTime)

        if !group.groupImage.isEmpty, let image = UIImage(named: group.groupImage) {
            self.backgroundImage = image
        } else {
            self.backgroundImage = UIImage(named: "image") // ✅ 기본 이미지 설정
        }
    }

    // MARK: - 날짜 변환
    private func formatDate(_ isoDate: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime] //  `withFractionalSeconds` 제거했음
        guard let date = isoFormatter.date(from: isoDate) else {
            print("❌ 날짜 변환 실패: \(isoDate)") //  디버깅 로그 추가
            return "날짜 없음"
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.locale = Locale(identifier: "ko_KR") // 한국 로케일 적용
        outputFormatter.dateFormat = "yyyy년 MM월 dd일"

        return outputFormatter.string(from: date)
    }



    // MARK: - 샘플 데이터 로드
    private func loadSampleData() {
        print("🟢 loadSampleData() 실행됨")

        let sampleData = GroupAPITarget.getGroupInvite(inviteCode: "SAMPLE123").sampleData

        do {
            let sampleResponse = try JSONDecoder().decode(BaseResponseGroupInviteResult.self, from: sampleData)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // UI 갱신 딜레이 적용
                self.updateGroupInfo(with: sampleResponse.result) //  애니메이션 제거!
                print("✅ 샘플 데이터 로드 완료: \(self.groupName), \(self.groupLocation), \(self.groupDate)")
            }
        } catch {
            print("❌ 샘플 데이터 디코딩 실패: \(error.localizedDescription)")
            
            if let jsonString = String(data: sampleData, encoding: .utf8) {
                print("📌 샘플 데이터 원본: \(jsonString)")
            }
        }
    }

}
