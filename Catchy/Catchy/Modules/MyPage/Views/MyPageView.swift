//
//  MyPageView.swift
//  Catchy
//
//  Created by 권용빈 on 2/1/25.
//

import SwiftUI
import Kingfisher

/// 마이페이지 뷰
struct MyPageView: View {
    
    @State private var isVisible: Bool = false
    @StateObject var viewModel: MyPageViewModel
    @ObservedObject private var userState = UserState.shared
    @EnvironmentObject var container: DIContainer
    @EnvironmentObject var appFlowViewModel: AppFlowViewModel
    
    @Binding var isEditingNickname: Bool
    

    
    init(container: DIContainer, isEditingNickname: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: MyPageViewModel(container: container))
        self._isEditingNickname = isEditingNickname
    }
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 53) {
                if !viewModel.isProfileLoading && !viewModel.isBookmarkedCourseLoading {
                    if let profile = viewModel.profileResponse {
                        TopSectionView(data: profile)
                        BookmarkedCoursesView(content: viewModel.courseResponse)
                    } else {
                        Spacer()
                        CustomEmptyStateView(label: "프로필 정보를 찾을 수 없습니다.", subLabel: "")
                            .frame(maxWidth: .infinity)
                        Spacer()
                    }
                } else {
                    MainProgressComponents()
                }
            }
            .padding(.top, 62)
            .padding(.bottom, 110)
        }
        .opacity(isVisible ? 1 : 0)
        .background(Color(.g1))
        .safeAreaPadding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        .task {
            viewModel.getProfile()
            viewModel.getBookmarkCourseList(lastCourseId: nil)
        }
        .sheet(isPresented: $viewModel.isImagePickerPresented, content: {
            ImagePicker(imageHandler: viewModel, selectedLimit: 1)
        })
        .onAppear {
            withAnimation(.easeInOut(duration: 0.3)) {
                isVisible = true
            }
        }
        .fullScreenCover(isPresented: $viewModel.isPreferenceScreenView) {
            PreferencePageView(container: container, appFlowViewModel: appFlowViewModel, fromMyPage: true)
        }
    }
    
    // MARK: - 마이페이지 상단 섹션 함수
    private func TopSectionView(data: ProfileResponse) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            settingsButton()
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 12)
            ProfileSectionView(data: data)
                .padding(.bottom, 31)
            myPageMenuButtons()
        }
    }
    
    private func settingsButton() -> some View {
        Button(action: {
            container.navigationRouter.push(to: .mypageOption)
        }) {
            Icon.settingIcon.image
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
        }
    }
    
    private func ProfileSectionView(data: ProfileResponse) -> some View {
        HStack(spacing: 10) {
            ProfileImage(
                imageURL: data.profileImage,
                size: 104
            ) {
                viewModel.showImagePicker()
            }
            Text(userState.getUserNickname())
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(Color.black)
                .padding(.leading, 9)
            
            Button(action: {
                withAnimation {
                    isEditingNickname.toggle()
                }
            }) {
                Text("닉네임 수정")
                    .font(.caption)
                    .foregroundStyle(Color.g4)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 16)
                    .frame(width: 84, height: 32)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(.g2, lineWidth: 1)
                    )
            }
        }
    }
    
    private func myPageMenuButtons() -> some View {
        let menuItems: [(icon: Image, title: String, action: () -> Void)] = [
            (Icon.document.image, "취향 설문", {
                viewModel.isPreferenceScreenView = true
            }),
            (Icon.myPageHeart.image, "선호 장소", { container.navigationRouter.push(to: .favoritePlacesView) }),
            (Icon.myPageReview.image, "내 리뷰", { container.navigationRouter.push(to: .myReviewsView) })
        ]
        return HStack(spacing: 17) {
            ForEach(menuItems, id: \.title) { item in
                MyPageItem(icon: item.icon, title: item.title, onTap: item.action)
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private func BookmarkedCoursesView(content: [CourseResponseData]?) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("북마크한 코스")
                .font(.Subtitle3)
                .foregroundStyle(Color.g7)
            if let content = content, !content.isEmpty {
                ScrollView(.vertical) {
                    LazyVGrid(columns: [GridItem(.flexible())], spacing: 11) {
                        ForEach(content, id: \.id) { course in
                            CourseGroupCard(course: course, type: .myPage)
                                .onAppear {
                                    // 추가 로드 처리: 마지막 아이템에 도달 시
                                    if course.courseId == content.last?.courseId, !viewModel.isLastPage {
                                        viewModel.getBookmarkCourseList(lastCourseId: course.courseId)
                                    }
                                }
                                .onTapGesture {
                                    container.navigationRouter.push(to: .courseDetailView(courseId: course.courseId))
                                }
                        }
                    }
                }
            } else {
                CustomEmptyStateView(label: "북마크한 코스가 없습니다.", subLabel: "관심 있는 코스를 저장해 보세요!")
                    .frame(maxWidth: .infinity)
                    .padding(.top, 50)
                Spacer()
            }
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 16 Pro", "iPhone 11"], id: \.self) { deviceName in
            MyPageView(container: DIContainer(), isEditingNickname: .constant(true))
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
