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
    
    @StateObject var viewModel: MyPageViewModel
    
    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
    }
    
    // MARK: - Body

    var body: some View {
        
        VStack(alignment: .leading, spacing: 53, content: {
            if !viewModel.isProfileLoading && !viewModel.isBookmarkedCourseLoading {
                if let data = viewModel.profileResponse {
                    TopSectionView(data: data)
                    BookmarkedCoursesView(content: viewModel.courseResponse?.content)
                } else {
                    Spacer()
                    CustomEmptyStateView(label: "프로필 정보를 찾을 수 없습니다.", subLabel: "")
                        .frame(maxWidth: .infinity)
                    Spacer()
                    
                }
            } else {
                LoadingView()
            }
        })
        .background(Color(.g1))
        .safeAreaPadding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        .task {
            viewModel.getProfile()
            viewModel.getBookmarkCourseList(pageSize: 10, lastCourseId: 1)
        }
        .overlay(
            Group {
                if viewModel.isEditingNickname {
                    NicknameEditView(isPresented: $viewModel.isEditingNickname, container: DIContainer())
                }
            }
        )
    }
    
    // MARK: - 마이페이지 상단 섹션 함수
    
    /// 마이페이지 상단 섹션을 구성하는 뷰
    /// - Parameter data: 사용자 프로필 정보를 포함하는 `ProfileResponse` 객체
    /// - Returns: 설정 버튼, 프로픽 섹션 및 마이페이지 메뉴 버튼을 포함하는 뷰
    private func TopSectionView(data: ProfileResponse) -> some View {
        return VStack(alignment: .leading, spacing: 6, content: {

            settingsButton()
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 12)
            
            ProfileSectionView(data: data)
                .padding(.bottom, 31)
            
            myPageMenuButtons()
        })
    }
    
    
    /// 설정 버튼
    /// - Returns: 설정 버튼 뷰
    private func settingsButton() -> some View {
        return Button(action: {
            print("설정 버튼 클릭")
        }) {
            Icon.settingIcon.image
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
        }
    }
    
    /// 프로필 섹션
    /// - Parameter data: 사용자 프로필 정보를 포함하는 `ProfileResponse` 객체
    /// - Returns: 프로필 이미지, 닉네임 및 닉네임 수정 버튼을 포함하는 뷰
    private func ProfileSectionView(data: ProfileResponse) -> some View {
        return HStack(spacing: 10, content: {
            ProfileImage(
                imageURL: viewModel.profileResponse?.profileImage ?? "",
                size: 104
            ) {
                // TODO: - 프로필 수정 액션
                print("프로필 수정 클릭")
            }
            
            Text(viewModel.profileResponse?.nickname ?? "")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.leading, 9)
            
            Button(action: {
                viewModel.isEditingNickname = true
                // TODO: - 닉네임 수정 액션
            }) {
                Text("닉네임 수정")
                    .font(.caption)
                    .foregroundColor(.g4)
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
        })
    }
    
    /// 마이페이지 메뉴 버튼
    /// - Returns: 마이페이지 메뉴 아이템을 포함한 뷰
    // TODO: - 버튼 눌렀을 시 액션 추가, enum으로 관리
    private func myPageMenuButtons() -> some View {
        let menuItems: [(icon: Image, title: String, action: () -> Void)] = [
            (Icon.document.image, "취향 설문", { print("취향 설문 클릭") }),
            (Icon.myPageHeart.image, "선호 장소", { print("선호 장소 클릭") }),
            (Icon.myPageReview.image, "내 리뷰", { print("내 리뷰 클릭") })
        ]
        
        return HStack(spacing: 17) {
            ForEach(menuItems, id: \.title) { item in
                MyPageItem(icon: item.icon, title: item.title, onTap: item.action)
            }
        }
        .frame(maxWidth: .infinity)
        
    }
    
    // MARK: - 북마크 코스 섹션
    
    /// 북마크한 코스 목록
    /// - Parameter content: 사용자가 북마크한 코스 데이터
    /// - Returns: 북마크한 코스 목록을 포함한 뷰, 데이터가 없으면 가이드뷰
    private func BookmarkedCoursesView(content: [CourseResponseData]?) -> some View {
        
        
        return VStack(alignment: .leading, spacing: 15, content: {
            Text("북마크한 코스")
                .font(.Subtitle3)
                .foregroundStyle(Color.g7)
            
            if let content = content, !content.isEmpty {
                ScrollView(.vertical, content: {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 1), spacing: 11, content: {
                        ForEach(content, id: \.id) { course in
                            CourseGroupCard(course: course, type: .myPage)
                        }
                    })
                })
            } else {
                CustomEmptyStateView(label: "북마크한 코스가 없습니다.", subLabel: "관심 있는 코스를 저장해 보세요!")
                    .frame(maxWidth: .infinity)
                    .padding(.top, 50)
                Spacer()
            }
        })
    }
    
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 16 Pro", "iPhone 11"], id: \.self) { deviceName in
            MyPageView(container: DIContainer())
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
