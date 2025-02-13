//
//  CreateGroupDoneViewModel.swift
//  Catchy
//
//  Created by 임소은 on 2/11/25.
//

import SwiftUI
import Combine

class CreateGroupDoneViewModel: ObservableObject {
    @Published var groupName: String = "그룹 이름 없음"
    @Published var groupLocation: String = "위치 없음"
    @Published var groupDate: String = "날짜 없음"
    @Published var inviteCode: String = "초대 코드 없음"
    @Published var backgroundImage: UIImage?

    let container: DIContainer

    init(container: DIContainer) {
        self.container = container
    }

    // MARK: - 저장된 그룹 정보 불러오기
    @MainActor
    func loadGroupData() async {
        if let groupData = UserDefaults.standard.data(forKey: "createdGroupInfo"),
           let group = try? JSONDecoder().decode(CreateGroupResponse.self, from: groupData) {
            
            self.groupName = group.groupName
            self.groupLocation = group.groupLocation.isEmpty ? "위치 없음" : group.groupLocation
            self.groupDate = formatDate(group.promiseTime)
            self.inviteCode = group.inviteCode.isEmpty ? "초대 코드 없음" : group.inviteCode
            self.loadImage(from: group.groupImage)

            print("✅ 저장된 그룹 데이터 불러오기 성공:")
            print("   - 그룹 이름: \(self.groupName)")
            print("   - 위치: \(self.groupLocation)")
            print("   - 약속 날짜: \(self.groupDate)")
            print("   - 초대 코드: \(self.inviteCode)")
        } else {
            print("❌ 저장된 그룹 정보가 없습니다.")
        }
    }

    // MARK: - 날짜 포맷 변환
    private func formatDate(_ isoDate: String) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        if let date = formatter.date(from: isoDate) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "yyyy년 MM월 dd일"
            return outputFormatter.string(from: date)
        }

        print("❌ 날짜 변환 실패: \(isoDate)")
        return "날짜 없음"
    }

    // MARK: - 이미지 로드
    private func loadImage(from imageName: String?) {
        guard let imageName = imageName, !imageName.isEmpty else {
            print("❌ 이미지 이름이 없음")
            return
        }

        if let image = UIImage(named: imageName) {
            self.backgroundImage = image
            print("✅ 이미지 로드 성공: \(imageName)")
        } else {
            print("❌ 이미지 로드 실패: \(imageName)")
        }
    }
}
