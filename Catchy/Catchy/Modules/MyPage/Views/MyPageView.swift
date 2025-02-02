//
//  MyPageView.swift
//  Catchy
//
//  Created by 권용빈 on 2/1/25.
//

import SwiftUI
import Kingfisher

struct MyPageView: View {
    
    @StateObject var viewModel: MyPageViewModel
    
    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
    }
    
    // MARK: - Body
    var body: some View {
        
        VStack(alignment: .center, spacing: 20, content: {
            if !viewModel.isLoading {
                if let data = viewModel.profileResponse {
                    TopSectionView(data: data)
                    // 보일 뷰 작성
                    //.frame(maxWidth: .infinity)
                } else {
                    // 값을 들고 있지 않다면 가이드 보여주기
                }
            } else {
                Spacer()
                
                ProgressView()
                    .controlSize(.regular)
                
                Spacer()
            }
        })
        .ignoresSafeArea(.all)
        .safeAreaPadding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        .task {
            viewModel.getProfile()
        }
    }
    
    /// ✅ 마이페이지 상단 뷰 (설정 버튼 + 프로필 + 메뉴 버튼)
    private func TopSectionView(data: ProfileResponse) -> some View {
        return VStack(alignment: .leading, spacing: 20, content: {
            
            // 설정 버튼
            HStack {
                Spacer()
                settingsButton()
                    .padding(.trailing, 12)
            }
            
            // 프로필 섹션 (프로필 이미지 + 닉네임)
            ProfileSectionView(data: data)
            
            // 마이페이지 메뉴 버튼
            myPageMenuButtons()
        })
    }
    private func settingsButton() -> some View {
        Button(action: {
            print("설정 버튼 클릭")
        }) {
            Icon.settingIcon.image
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
        }
    }
    
    private func ProfileSectionView(data: ProfileResponse) -> some View {
        return HStack(spacing: 10, content: {
            ProfileImage(
                imageURL: viewModel.profileResponse?.profileImage ?? "",
                size: 104
            ) {
                print("프로필 수정 클릭")
            }
            
            
            Text(viewModel.profileResponse?.nickname ?? "")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.leading, 9)
            Button(action: {
                print("닉네임 수정 클릭")
                // TODO: - 닉네임 수정 액션
            }) {
                Text("닉네임 수정")
                    .font(.caption)
                    .foregroundColor(.g4)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 16)
                    .frame(width: 84, height: 32)
                    .background(.g1)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
            }
        })
    }
    
    // TODO: - 버튼 눌렀을 시 액션 추가
    private func myPageMenuButtons() -> some View {
        let menuItems: [(icon: Image, title: String, action: () -> Void)] = [
            (Icon.document.image, "취향 설문", { print("취향 설문 클릭") }),
            (Icon.myPageHeart.image, "선호 장소", { print("선호 장소 클릭") }),
            (Icon.myPageReview.image, "내 리뷰", { print("내 리뷰 클릭") })
        ]
        
        return HStack(spacing: 17, content: {
            ForEach(menuItems, id: \.title) { item in
                MyPageItem(icon: item.icon, title: item.title, onTap: item.action)
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
