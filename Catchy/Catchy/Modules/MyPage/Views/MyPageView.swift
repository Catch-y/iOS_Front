//
//  MyPageView.swift
//  Catchy
//
//  Created by 권용빈 on 2/1/25.
//

import SwiftUI

struct MyPageView: View {
    
    @StateObject var viewModel: MyPageViewModel
    
    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
    }
    
    var body: some View {
        
        VStack{
            myPageMenuButtons()
        }
        
        
        
    }
    
    private var ProfileSectionView: some View {
        HStack {
            ProfileImage(
                imageURL: "viewModel.profileImageUrl",
                size: 80
            ) {
                print("프로필 수정 클릭")
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("viewModel.nickname")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Button(action: {
                    print("닉네임 수정 클릭")
                }) {
                    Text("닉네임 수정")
                        .font(.system(size: 12, weight: .medium))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color(.systemGray5))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
    }
    
    private func myPageMenuButtons() -> some View {
        return HStack(spacing: 12, content: {
            MyPageItem(icon: Icon.document.image, title: "취향 설문") {
                print("취향 설문 클릭")
            }
            
            MyPageItem(icon: Icon.myPageHeart.image, title: "선호 장소") {
                print("선호 장소 클릭")
            }
            
            MyPageItem(icon: Icon.myPageReview.image, title: "내 리뷰") {
                print("내 리뷰 클릭")
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
