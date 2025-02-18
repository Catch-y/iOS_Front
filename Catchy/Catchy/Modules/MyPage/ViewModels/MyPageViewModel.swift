//
//  MyPageViewModel.swift
//  Catchy
//
//  Created by 권용빈 on 2/1/25.
//

import SwiftUI
import Combine

class MyPageViewModel: ObservableObject, ImageHandling {
    
    // MARK: - MyPage View Properties
    
    /// 마이페이지 프로필 조회 response
    @Published var profileResponse: ProfileResponse?
    
    /// 북마크한 코스 조회 response
    @Published var courseResponse: [CourseResponseData]?
    
    /// 마이페이지 프로필 조회 API 로딩 중?
    @Published var isProfileLoading: Bool = false
    
    /// 북마크한 코스 조회 API 로딩 중?
    @Published var isBookmarkedCourseLoading: Bool = false
    
    /// 닉네임 수정 모달 상태 추가
    @Published var isEditingNickname: Bool = false
    
    var profileImage: [UIImage] = [] {
        didSet {
            if let newValue = profileImage.first {
                uploadProfileImage(profileImage: newValue)
            }
        }
    }
    
    @Published var isImagePickerPresented: Bool = false
    
    var selectedImageCount: Int = 1
    
    /// 현재 받아온 페이지
    var currentPage: Int = 1
    
    /// 마지막 페이지?
    var isLastPage: Bool = false
    
    let container: DIContainer
    
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(container: DIContainer) {
        self.container = container
    }
}

extension MyPageViewModel {
    
    /// 마이페이지 프로필 조회
    func getProfile() {
        guard !isProfileLoading else { return }
        isProfileLoading = true
        
        container.useCaseProvider.myPageUseCase
            .executeGetProfile()
            .tryMap { responseData -> ResponseData<ProfileResponse> in
                if !responseData.isSuccess {
                    throw APIError.serverError(
                        message: responseData.message,
                        code: responseData.code
                    )
                }
                return responseData
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isProfileLoading = false
                switch completion {
                case .finished:
                    print("✅ Get Profile Server Completed")
                case .failure(let failure):
                    print("❌ Get Profile Failed: \(failure)")
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                if let result = response.result {
                    self.profileResponse = result
                }
            }
            .store(in: &cancellables)
    }
    
    /// 북마크한 코스 무한 스크롤
    func getBookmarkCourseList(lastCourseId: Int? = nil) {
        guard !isBookmarkedCourseLoading, !isLastPage else { return }
        isBookmarkedCourseLoading = true
        
        container.useCaseProvider.myPageUseCase
            .executeGetBookmarkCourseList(pageSize: 10, lastCourseId: lastCourseId)
            .tryMap { responseData -> ResponseData<CourseResponse> in
                if !responseData.isSuccess {
                    throw APIError.serverError(
                        message: responseData.message,
                        code: responseData.code
                    )
                }
                return responseData
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isBookmarkedCourseLoading = false
                switch completion {
                case .finished:
                    print("✅ Get Bookmark Courses Server Completed")
                case .failure(let failure):
                    print("❌ Get Bookmark Courses Failed: \(failure)")
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                if let result = response.result {
                    if result.content.isEmpty {
                        self.courseResponse = nil
                    } else {
                        if self.courseResponse == nil {
                            self.courseResponse = result.content
                        } else {
                            self.courseResponse?.append(contentsOf: result.content)
                        }
                        self.isLastPage = result.isLast
                        if !self.isLastPage {
                            self.currentPage += 1
                        }
                    }
                }
                print("🔍 More Third Section updated: \(String(describing: response.result))")
            }
            .store(in: &cancellables)
    }
}

extension MyPageViewModel {
    
    func addImage(_ images: UIImage) {
        if !profileImage.isEmpty {
            profileImage.removeAll()
        }
        
        profileImage.append(images)
    }
    
    func getImages() -> [UIImage] {
        return profileImage
    }
    
    func removeImage(at index: Int) {
        profileImage.remove(at: index)
    }
    
    func showImagePicker() {
        isImagePickerPresented.toggle()
        print(isImagePickerPresented)
    }
    
    func uploadProfileImage(profileImage: UIImage) {
            container.useCaseProvider.myPageUseCase.executePatchProfileImage(profileImage: profileImage)
                .tryMap { responseData -> ResponseData<EditProfileResponse> in
                    if !responseData.isSuccess {
                        throw APIError.serverError(message: responseData.message, code: responseData.code)
                    }
                    
                    guard let _ = responseData.result else {
                        throw APIError.emptyResult
                    }
                    
                    print("✅ Patch ProfileImage \(responseData)")
                    return responseData
                }
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("✅ Patch ProfileImage Success")
                    case .failure(let failure):
                        print("❌ Patch ProfileImage Failure: \(failure)")
                    }
                }, receiveValue: { [weak self] response in
                    guard let self = self else { return }
                    
                    if let response = response.result {
                        print("PatchProfileImage: \(response)")
                        profileResponse?.profileImage = response.profileImage
                    }
                })
                .store(in: &cancellables)
    }
}
