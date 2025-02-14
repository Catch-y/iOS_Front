//
//  CreateGroupViewModel.swift
//  Catchy
//
//  Created by 임소은 on 2/10/25.
//

import SwiftUI
import Combine
import Moya
import PhotosUI

/// 뷰 모델
final class CreateGroupViewModel: ObservableObject {
    @Published var groupName: String = ""
    @Published var selectedDate: Date = Date()
    @Published var groupLocation: String = ""
    @Published var inviteCode: String = ""
    @Published var groupImage: UIImage? = nil
    @Published var selectedItem: PhotosPickerItem? = nil {
        didSet { loadImage() }
    }
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false

    let container: DIContainer
    private let provider = MoyaProvider<GroupAPITarget>()
    private var cancellables = Set<AnyCancellable>()

    init(container: DIContainer) {
        self.container = container
    }

    // MARK: - 그룹 생성 API 호출 (API Target의 샘플 데이터 활용)
    func createGroup() {
        guard !groupName.isEmpty, !groupLocation.isEmpty else {
            errorMessage = "그룹 이름과 위치를 입력해주세요."
            return
        }

        isLoading = true

        let request = CreateGroupRequest(
            groupName: groupName,
            groupLocation: groupLocation,
            promiseTime: formatDate(selectedDate),
            inviteCode: generateInviteCode(),
            groupImage: groupImage?.jpegData(compressionQuality: 0.8)
        )

        provider.requestPublisher(.postCreateGroup(createGroup: request))
            .map { response -> ResponseData<CreateGroupResponse>? in
                return try? JSONDecoder().decode(ResponseData<CreateGroupResponse>.self, from: response.data)
            }
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.isLoading = false
                if case let .failure(error) = completion {
                    self.errorMessage = "❌ API 요청 실패: \(error.localizedDescription)"
                    print("⚠️ 서버 응답 실패: API Target의 샘플 데이터 활용")
                }
            } receiveValue: { responseData in
                if let responseData = responseData, responseData.isSuccess, let groupData = responseData.result {
                    self.inviteCode = groupData.inviteCode
                    UserDefaults.standard.set(try? JSONEncoder().encode(groupData), forKey: "createdGroupInfo")
                    print("✅ 그룹 생성 성공: \(groupData)")
                } else {
                    self.errorMessage = responseData?.message ?? "서버 응답이 없습니다."
                    print("⚠️ API Target의 샘플 데이터 활용")
                }
            }
            .store(in: &cancellables)
    }

    // MARK: - 날짜 포맷 변환
    private func formatDate(_ date: Date) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.string(from: date)
    }

    // MARK: - 초대 코드 생성
    private func generateInviteCode() -> String {
        return UUID().uuidString.prefix(8).uppercased()
    }

    // MARK: - 이미지 로드 (Task 오류 해결: DispatchQueue 사용)
    private func loadImage() {
        guard let selectedItem = selectedItem else { return }

        DispatchQueue.global(qos: .userInitiated).async {
            selectedItem.loadTransferable(type: Data.self) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let imageData):
                        if let imageData = imageData, let image = UIImage(data: imageData) {
                            self.groupImage = image
                        }
                    case .failure(let error):
                        print("❌ 이미지 로드 실패: \(error.localizedDescription)")
                    }
                }
            }
        }
    }

}
