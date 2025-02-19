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
    @Published var groupId: Int = 0
    @Published var groupName: String = "그룹 이름 없음"
    @Published var groupLocation: String = "위치 없음"
    @Published var groupDate: String = "날짜 없음"
    @Published var inviteCode: String
    @Published var backgroundImageURL: URL? //  URL 타입으로 변경

    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let container: DIContainer
    
    private let provider = MoyaProvider<GroupAPITarget>()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(container: DIContainer, inviteCode: String = "") {
        self.container = container
        self.inviteCode = inviteCode
    }
    
    // MARK: - 그룹 데이터 로드
    func loadGroupData() async {
        print("🟢 loadGroupData() 실행됨")


        self.isLoading = true
        defer { self.isLoading = false }

        do {
            print("🚀 API 요청 시작: \(inviteCode)")

            let response = try await withCheckedThrowingContinuation { continuation in
                provider.request(.getGroupInvite(inviteCode: inviteCode)) { result in
                    switch result {
                    case .success(let moyaResponse):
                        continuation.resume(returning: moyaResponse)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }

            let decoded = try JSONDecoder().decode(BaseResponseGroupInviteResult.self, from: response.data)

            if decoded.isSuccess {
                updateGroupInfo(with: decoded.result)
            } else {
                self.errorMessage = decoded.message
                print("❌ API 실패: \(decoded.message)")
                loadSampleData()
            }
            
        } catch {
            self.errorMessage = "❌ API 요청 실패: \(error.localizedDescription)"
            print("❌ API 요청 실패: \(error.localizedDescription)")
            loadSampleData()
        }
    }

    // MARK: - 그룹정보 업데이트
    private func updateGroupInfo(with group: GroupInviteResponse) {
        self.groupName = group.groupName
        self.groupLocation = group.groupLocation.isEmpty ? "위치 없음" : group.groupLocation
        self.groupDate = formatDate(group.promiseTime)

        // ✅ 서버에서 받은 이미지 URL을 안전하게 변환
        let imageURLString = group.groupImage  // `String` 타입이라면 옵셔널 바인딩 불필요
        if !imageURLString.isEmpty, let validURL = URL(string: imageURLString) {
            self.backgroundImageURL = validURL
        } else {
            self.backgroundImageURL = nil // 기본 이미지 적용
        }
    }


    // MARK: - 날짜 변환
    private func formatDate(_ isoDate: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime]
        guard let date = isoFormatter.date(from: isoDate) else {
            return "날짜 없음"
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.locale = Locale(identifier: "ko_KR")
        outputFormatter.dateFormat = "yyyy년 MM월 dd일"

        return outputFormatter.string(from: date)
    }

    // MARK: - 샘플 데이터 로드
    private func loadSampleData() {
        print("🟢 loadSampleData() 실행됨")

        let sampleData = GroupAPITarget.getGroupInvite(inviteCode: "SAMPLE123").sampleData

        do {
            let sampleResponse = try JSONDecoder().decode(BaseResponseGroupInviteResult.self, from: sampleData)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.updateGroupInfo(with: sampleResponse.result)
            }
        } catch {
            print("❌ 샘플 데이터 디코딩 실패: \(error.localizedDescription)")
        }
    }
}
