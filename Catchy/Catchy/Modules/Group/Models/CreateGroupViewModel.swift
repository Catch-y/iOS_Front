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

/// 그룹 생성 뷰 모델
final class CreateGroupViewModel: ObservableObject, ImageHandling {
    
    let calendarViewModel: CalenderViewModel
    
    // MARK: - Published Properties
    @Published var isImagePickerPresented: Bool = false
    @Published public var selectedImageCount: Int = 0
    
    @Published var groupName: String = ""
    @Published var selectedDate: Date = Date()
    @Published var groupLocation: String = ""
    @Published var inviteCode: String = ""
    @Published var promiseTime: String = ""
    
    @Published var groupImage: UIImage? = nil {
        didSet {
            selectedImageCount = groupImage != nil ? 1 : 0
        }
    }
    @Published var groupImageURL : String? = nil
    
    @Published var selectedItem: PhotosPickerItem? = nil {
        didSet { loadImage() }
    }
    
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var createdGroup: GroupResult? //  GroupResult로 변경

    let container: DIContainer
    private let groupRepository: GroupRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initializer
    init(container: DIContainer, calendarViewModel: CalenderViewModel, groupRepository: GroupRepositoryProtocol = GroupRepository()) {
        self.container = container
        self.calendarViewModel = calendarViewModel
        self.groupRepository = groupRepository
    }

    // MARK: - 그룹 생성 API 호출
    func createGroup() {
        guard !groupName.isEmpty, !groupLocation.isEmpty else {
            errorMessage = "그룹 이름과 위치를 입력해주세요."
            return
        }

        isLoading = true
        errorMessage = ""
        
        // 저장된 `UserDefaults` 값 활용
        _ = UserDefaults.standard.string(forKey: "groupName") ?? groupName
        _ = groupImageURL // 🔹 서버 이미지 URL
        _ = UserDefaults.standard.string(forKey: "promiseTime") ?? formatDate(selectedDate)

        // `GroupInfo` 객체 생성
        let groupInfo = GroupInfo(
            groupName: "Study Group",
            groupLocation: ["서울특별시", "광진구"],
            promiseTime: "2025-02-20T05:08:03.006Z",
            groupImage: "https://i.pinimg.com/474x/1a/e2/8f/1ae28fe7bd5e3211be36f7a48b976226.jpg"
        )


        groupRepository.postCreateGroup(group: groupInfo)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = "❌ API 요청 실패: \(error.localizedDescription)"
                    print("⚠️ 서버 응답 실패: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] responseData in
                guard let self = self else { return }

                if responseData.isSuccess, let groupResult = responseData.result?.result {
                    self.inviteCode = groupResult.inviteCode
                    self.createdGroup = groupResult // GroupResult로 저장
                    self.groupImageURL = groupResult.groupImage
                    UserDefaults.standard.set(try? JSONEncoder().encode(groupResult), forKey: "createdGroupInfo")
                    print("✅ 그룹 생성 성공: \(groupResult)")
                    self.addGroupToCalendar(groupResult) // ✅ 캘린더에 추가
                } else {
                    self.errorMessage = responseData.message
                    print("⚠️ API 응답 오류")
                }

            }
            .store(in: &cancellables)
    }

    // MARK: - 캘린더에 그룹 추가
    private func addGroupToCalendar(_ group: GroupResult) {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        if let date = dateFormatter.date(from: group.promiseTime) {
            let normalizedDate = Calendar.current.startOfDay(for: date)
            DispatchQueue.main.async {
                self.calendarViewModel.schedules[normalizedDate, default: []].append(group.groupName)
                print("📅 캘린더에 추가된 그룹: \(group.groupName) on \(normalizedDate)")
            }
        }
    }

    // MARK: - 날짜 포맷 변환
    private func formatDate(_ date: Date) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.string(from: date)
    }

    // MARK: - 이미지 로드
    private func loadImage() {
        guard let selectedItem = selectedItem else { return }

        DispatchQueue.global(qos: .userInitiated).async {
            selectedItem.loadTransferable(type: Data.self) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let imageData):
                        if let imageData = imageData, let image = UIImage(data: imageData) {
                            self.groupImage = image
                            self.groupImageURL = nil
                        }
                    case .failure(let error):
                        print("❌ 이미지 로드 실패: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}

// MARK: - ImageHandling 프로토콜 구현
extension CreateGroupViewModel {
    
    func addImage(_ images: UIImage) {
        self.groupImage = images
    }

    func removeImage(at index: Int) {
        self.groupImage = nil
    }
    
    func showImagePicker() {
        self.isImagePickerPresented.toggle()
    }
    
    func getImages() -> [UIImage] {
        guard let image = self.groupImage else {
            return []
        }
        return [image]
    }
}
