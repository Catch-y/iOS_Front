//
//  VoteDoneView.swift
//  Catchy
//
//  Created by 임소은 on 2/5/25.
//

import SwiftUI


struct VoteDoneView: View {
    @EnvironmentObject var container: DIContainer

   
    
    // MARK: - Body
    var body: some View {
        VStack {
            // MARK: - 네비게이션 바
            GroupNavigation(title: "투표하기", onBackButtonTap: {
                container.navigationRouter.pop() //  이전 화면으로 이동
            })
            
            Spacer()
            
            // MARK: - 투표 완료 텍스트 & 아이콘
            voteDoneContent
                .padding(.bottom, 292)

            // MARK: - 투표 결과 확인 버튼
            confirmButton
        }
        .background(mainBackground) // 전체 배경
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - 투표 완료 내용
    private var voteDoneContent: some View {
        VStack(spacing: 16) {
            Icon.allSelectCheckBtn.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 45, height: 45)
                .foregroundStyle(Color.m5)
                .padding(.bottom, 33)

            Text("투표가 완료되었습니다 \n 투표 결과를 확인해보세요!")
                .font(.Subtitle2)
                .foregroundStyle(.g6)
        }
        .multilineTextAlignment(.center)
    }
    
    // MARK: - 투표 결과 확인 버튼
    private var confirmButton: some View {
        Button(action: {
            container.navigationRouter.push(to: .voteDoneCategoryView(groupId: 1, voteId: 123))
        }) {
            Text("투표 결과 확인하기")
                .font(.Subtitle3)
                .foregroundStyle(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.m5)
                )
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 20)
    }
}

// MARK: - 배경 뷰
private var mainBackground: some View {
    ZStack {
        // MARK: - 메인 컬러 그라데이션 배경
        LinearGradient(
            gradient: Gradient(colors: [Color.white, Color.white]),
            startPoint: .top,
            endPoint: .bottom
        )
        
        
        // MARK: - 타원형 블러 배경
        Rectangle()
            .foregroundStyle(.clear)
            .frame(width: 625, height: 361)
            .background(Color(red: 1, green: 0.32, blue: 0.49).opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .blur(radius: 125)
            .opacity(0.3)
    }
    .padding(.top, 204)
    .edgesIgnoringSafeArea(.all)
}

// MARK: - Preview
struct VoteDoneView_Previews: PreviewProvider {
    static var previews: some View {
        VoteDoneView()
            .environmentObject(DIContainer())
    }
}
