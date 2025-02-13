//
//  CreateGroupViewModel.swift
//  Catchy
//
//  Created by 임소은 on 2/10/25.
//

import SwiftUI
import PhotosUI
import Moya
import Combine

class CreateGroupViewModel: ObservableObject {
    @Published var groupName: String = ""
    @Published var selectedDate: Date = Date()
    @Published var groupImage: UIImage? = nil
    @Published var selectedItem: PhotosPickerItem? = nil {
        didSet {
            loadImage()
        }
    }

    let container: DIContainer
    let provider = MoyaProvider<CreateGroupAPITarget>(stubClosure: MoyaProvider.immediatelyStub) // 샘플데이터로드

    init(container: DIContainer) {
        self.container = container
    }

    // MARK: - 그룹 데이터 초기화 (새 그룹 생성 시 실행)
    func resetGroupData() {
        groupName = ""
        selectedDate = Date()
        groupImage = nil
        selectedItem = nil
        print("🔄 그룹 데이터 초기화 완료")
    }

    // MARK: - "다음" 버튼을 눌렀을 때 저장
    func saveGroupData() {
        let data = GroupData(
            groupName: groupName,
            promiseTime: formatDate(selectedDate)
        )
        if let encoded = try? JSONEncoder().encode(data) {
            UserDefaults.standard.set(encoded, forKey: "tempGroupInfo")
            print("✅ 그룹 데이터 저장됨: \(groupName), \(selectedDate)")
        }
    }

    // MARK: - 그룹 생성 API 호출
    func createGroup() {
        print("✅ 그룹 생성 시작: \(groupName), \(selectedDate)")

        guard !groupName.isEmpty else {
            print("❌ 그룹 이름이 비어있음")
            return
        }

        let request = CreateGroupRequest(
            groupName: groupName,
            groupLocation: "", // 그룹 위치는 다른 페이지에서 입력받으므로 빈값
            promiseTime: formatDate(selectedDate),
            inviteCode: generateInviteCode(),
            groupImage: groupImage?.jpegData(compressionQuality: 0.8)
        )

        provider.request(.postCreateGroup(creategroup: request)) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    do {
                        let decodedResponse = try JSONDecoder().decode(CreateGroupResponse.self, from: response.data)
                        print("✅ 그룹 생성 성공: \(decodedResponse.groupName)")

                        // 🔹 API 성공 후 최종 저장
                        if let groupData = try? JSONEncoder().encode(decodedResponse) {
                            UserDefaults.standard.set(groupData, forKey: "createdGroupInfo")
                        }
                    } catch {
                        print("❌ 디코딩 오류: \(error.localizedDescription)")
                    }
                case .failure(let error):
                    print("❌ API 요청 실패: \(error.localizedDescription)")
                }
            }
        }
    }

    // MARK: - 날짜 포맷 변환 (ISO8601)
    private func formatDate(_ date: Date) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.string(from: date)
    }

    // MARK: - 초대 코드 생성
    private func generateInviteCode() -> String {
        return UUID().uuidString.prefix(6).uppercased()
    }

    // MARK: - 이미지 로드
    private func loadImage() {
        guard let selectedItem = selectedItem else { return }
        selectedItem.loadTransferable(type: Data.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if let data = data, let uiImage = UIImage(data: data) {
                        self.groupImage = uiImage
                    } else {
                        print("❌ 이미지를 로드할 수 없습니다.")
                    }
                case .failure(let error):
                    print("❌ 이미지 로드 오류: \(error.localizedDescription)")
                }
            }
        }
    }
}

// MARK: - GroupData 모델 (UserDefaults 저장용)
struct GroupData: Codable {
    let groupName: String
    let promiseTime: String
}
