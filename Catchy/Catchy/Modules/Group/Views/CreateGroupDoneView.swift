//
//  CreateGroupDoneView.swift
//  Catchy
//
//  Created by 임소은 on 2/11/25.
//

import SwiftUI

struct CreateGroupDoneView: View {
    @StateObject private var viewModel: CreateGroupDoneViewModel

    // MARK: - 초기화
    init(container: DIContainer) {
        _viewModel = StateObject(wrappedValue: .init(container: container))
    }

    var body: some View {
        ZStack {
            backgroundView
            content
        }
        .task {
            await viewModel.loadGroupData()
        }

    }

    // MARK: - 배경 뷰
    private var backgroundView: some View {
        Group {
            if let backgroundImage = viewModel.backgroundImage {
                Image(uiImage: backgroundImage)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .blur(radius: 10)
            } else {
                Color.g2.edgesIgnoringSafeArea(.all)
            }
        }
    }

    // MARK: - 그룹 이름 , 날짜
    private var content: some View {
        VStack {
            closeButton
            
            groupInfo
                .padding(.top, 184)
                .padding(.leading ,31)
                .padding(.trailing ,128)
            
            Spacer()
            
            actionButton
                .padding(.bottom, 40)
                .padding(.horizontal ,16)
            
        }
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
        .padding(.bottom, 50)
    }

    // MARK: - 참여하기 버튼
    private var actionButton: some View {
        Button(action: {
            print("참여하기 버튼 클릭")
        }) {
            Text("참여하기")
                .font(.Subtitle3)
                .foregroundColor(.m5) // 글자 색상
                .frame(maxWidth: .infinity, minHeight: 50) //  버튼 크기 고정
                .background(
                            RoundedRectangle(cornerRadius: 28)
                                .fill(Color.white)
                               )//  배경색 지정
                
        }
        .buttonStyle(.plain) // 기본 버튼 스타일 제거
    }





    // MARK: - 닫기 버튼
    private var closeButton: some View {
        HStack {
            Spacer()
            Button(action: {
                print("닫기 버튼 클릭")
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .frame(width: 24, height: 24)
                    .padding()
            }
            .padding()
            .s2t()
        }
        .padding(.top, 10)
    }
}

// MARK: - 미리보기
struct CreateGroupDoneView_Previews: PreviewProvider {
    static var previews: some View {
        let container = DIContainer() // 예제용 DIContainer
        return CreateGroupDoneView(container: container)
    }
}
