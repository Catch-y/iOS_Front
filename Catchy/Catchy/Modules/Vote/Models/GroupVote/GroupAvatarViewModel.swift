//
//  GroupAvatarViewModel.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine
import Moya

class GroupAvatarViewModel: ObservableObject {
    // MARK: - Properties
    @Published var avatars: [UserAvatarModel] = []
    private var cancellables = Set<AnyCancellable>()
    private var provider = MoyaProvider<GroupMembersAPITarget>()

    // MARK: - 그룹 멤버 조회 API 호출
    func fetchGroupMembers(groupId: Int) {
        let request = GroupMembersRequest(groupId: groupId)
        provider.request(.getGroupMembers(groupMemberRequest: request)) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(BaseResponseListGroupMemberResponse.self, from: response.data)
                    if decodedData.isSuccess, let members = decodedData.result {
                        DispatchQueue.main.async {
                            self.avatars = members.map { member in
                                UserAvatarModel(imageName: member.profileImage)
                            }
                            print("✅ API 데이터 로드 성공")
                        }
                    } else {
                        print("❌ 서버 오류 발생: \(decodedData.message)")
                        self.loadSampleData() // 샘플 데이터 로드
                    }
                } catch {
                    print("❌ 데이터 디코딩 실패: \(error)")
                    self.loadSampleData() // 샘플 데이터 로드
                }
            case .failure(let error):
                print("❌ API 요청 실패: \(error.localizedDescription)")
                self.loadSampleData() // 샘플 데이터 로드
            }
        }
    }

    // MARK: - 샘플 데이터 로드
    private func loadSampleData() {
        guard let sampleResponse = try? JSONDecoder().decode(
            BaseResponseListGroupMemberResponse.self,
            from: GroupMembersAPITarget.getGroupMembers(groupMemberRequest: GroupMembersRequest(groupId: 1)).sampleData
        ) else {
            print("❌ 샘플 데이터 디코딩 실패")
            return
        }

        DispatchQueue.main.async {
            if let members = sampleResponse.result {
                self.avatars = members.map { member in
                    UserAvatarModel(imageName: member.profileImage)
                }
                print("✅ 샘플 데이터 로드 성공")
            } else {
                print("❌ 샘플 데이터에 멤버가 없습니다.")
            }
        }
    }
}
