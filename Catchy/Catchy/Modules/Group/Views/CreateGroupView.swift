//
//  CreateGroupView.swift
//  Catchy
//
//  Created by 임소은 on 2/10/25.
//

import SwiftUI
import PhotosUI

struct CreateGroupView: View {
    @StateObject private var viewModel: CreateGroupViewModel

    // MARK: - 초기화
    init(container: DIContainer) {
        _viewModel = StateObject(wrappedValue: .init(container: container))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            GroupNavigation(title: "새 그룹 만들기") {
                print("뒤로가기 버튼 클릭")
            }

            ScrollView {
                VStack(alignment: .leading, spacing: 48) {
                    groupNameInput
                    groupImagePicker
                    calendarSelection
                    
                    Spacer()
                    
                    NextButton(title: "다음") {
                        viewModel.createGroup()
                    }
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(viewModel.isLoading ? Color.gray : Color.m5)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .foregroundStyle(.white)
                    .disabled(viewModel.isLoading)
                }
            }
            .padding(.horizontal, 16)
        }
        .padding(.bottom, 110)
    }

    // MARK: - 그룹 이름 입력
    private var groupNameInput: some View {
        VStack(alignment: .leading, spacing: 21) {
            Text("우리 그룹의 이름을 설정해주세요!")
                .font(.Subtitle3)
                .foregroundStyle(.g7)
            TextField("최대 10자까지 입력 가능합니다.", text: $viewModel.groupName)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.g3, lineWidth: 1)
                )
        }
    }

    // MARK: - 그룹 이미지 선택
    private var groupImagePicker: some View {
        VStack(alignment: .leading, spacing: 21) {
            Text("그룹을 대표할 이미지를 설정해주세요")
                .font(.Subtitle3)
                .foregroundStyle(.g7)

            PhotosPicker(
                selection: $viewModel.selectedItem,
                matching: .images,
                photoLibrary: .shared()
            ) {
                if let groupImage = viewModel.groupImage {
                    Image(uiImage: groupImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 214, height: 137)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                } else {
                    HStack {
                        Icon.voteStartButton.image
                        Text("사진 첨부하기")
                            .font(.body3)
                            .foregroundStyle(.g4)
                    }
                    .frame(width: 193, height: 42)
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.g3, lineWidth: 1)
                    )
                }
            }
        }
    }

    // MARK: - 캘린더 선택
    private var calendarSelection: some View {
        VStack(alignment: .leading, spacing: 21) {
            Text("모임 날짜를 선택해주세요")
                .font(.Subtitle3)
                .foregroundStyle(.g7)

            CreateCalenderView(container: viewModel.container)
        }
    }
}


// MARK: - Preview
struct CreateGroupView_Previews: PreviewProvider {
    static var previews: some View {
        let container = DIContainer()
        return CreateGroupView(container: container)
    }
}
