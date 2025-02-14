//
//  CreateGroupDoneView.swift
//  Catchy
//
//  Created by 임소은 on 2/11/25.
//

import SwiftUI

struct CreateGroupDoneView: View {
    @StateObject private var viewModel: CreateGroupDoneViewModel
    
    // MARK: - Init
    init(container: DIContainer, inviteCode: String = "") {
        _viewModel = StateObject(
            wrappedValue: CreateGroupDoneViewModel(
                container: container,
                inviteCode: inviteCode
            )
        )
    }

    var body: some View {
        ZStack(alignment: .top) { //  상단 정렬 추가
            backgroundView
                .zIndex(0) //  배경이 가장 아래로 가도록 설정
            
            VStack {
                content
            }
            .zIndex(1) //  콘텐츠가 배경 위에 위치하도록 설정
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) //  화면 크기 유지
        .task {
            await viewModel.loadGroupData()
        }
    }



    // MARK: - 뒷베경
    private var backgroundView: some View {
        GeometryReader { geometry in
            Group {
                if let backgroundImage = viewModel.backgroundImage {
                    Image(uiImage: backgroundImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height) //  크기 조정
                        .edgesIgnoringSafeArea(.all)
                        .blur(radius: 10)
                } else {
                    Color.g2
                        .frame(width: geometry.size.width, height: geometry.size.height) // 배경 크기 고정
                        .edgesIgnoringSafeArea(.all)
                }
            }
        }
    }


    // MARK: - 그룹 이름, 날짜
    private var content: some View {
        VStack {
            closeButton

            groupInfo
                .padding(.top, 180) // 상단 여백 유지
                .padding(.horizontal, 16) //  패딩 유지

            Spacer()

            actionButton
                .padding(.bottom, 40)
                .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity, alignment: .leading) // 패딩 유지
    }

   
    // MARK: - 그룹 정보
    private var groupInfo: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(viewModel.groupName)
                .font(.Headline2)
                .foregroundStyle(.white)
                .s2t()
            
            HStack {
                Text("모임 일정")
                    .font(.body3)
                    .foregroundStyle(.g2)
                    .s2t()
                Text("\(viewModel.groupDate), \(viewModel.groupLocation)")
                    .font(.body1)
                    .foregroundStyle(.g2)
                    .s2t()
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading) //  왼쪽 정렬
        .padding(.horizontal, 16)
        .padding(.bottom, 50)
        
    }


    // MARK: - 참여하기 버튼
    private var actionButton: some View {
        Button(action: {
            print("참여하기 버튼 클릭")
        }) {
            Text("참여하기")
                .font(.Subtitle3)
                .foregroundStyle(.m5)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 28)
                        .fill(Color.white)
                )
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 40)
    }
    // MARK: - 닫기 버튼
    private var closeButton: some View {
        HStack {
            Spacer()
            Button(action: {
                print("닫기 버튼 클릭")
            }) {
                Icon.close.image
                    .frame(width: 50, height: 50)
                    .padding()
            }
            .padding()
            .s2t()
        }
        .padding(.top, 10)
    }
}

// MARK: - Preview
struct CreateGroupDoneView_Previews: PreviewProvider {
    static var previews: some View {
        let container = DIContainer()
        
        // 1) inviteCode 미전달
        CreateGroupDoneView(container: container)
        
        // 2) inviteCode 전달
        // CreateGroupDoneView(container: container, inviteCode: "ABC123")
    }
}
