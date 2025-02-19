//
//  CreateGroupView.swift
//  Catchy
//
//  Created by 임소은 on 2/10/25.
//

import SwiftUI
import PhotosUI

struct CreateGroupView: View {
    
    @EnvironmentObject var container: DIContainer
    @StateObject private var viewModel: CreateGroupViewModel



    // MARK: - 초기화
    init(container: DIContainer) {
        _viewModel = StateObject(wrappedValue: .init(container: container))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            GroupNavigation(title: "새 그룹 만들기") {
                container.navigationRouter.pop() //  이전 화면으로 이동
            }


            ScrollView {
                VStack(alignment: .leading, spacing: 48) {
                    groupNameInput
                    groupImagePicker
                    calendarSelection
                    
                    Spacer()
                    
                    NextButton(title: "다음") {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            viewModel.createGroup()
                            container.navigationRouter.push(to: .locationSelectView)
                        }
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
        .sheet(isPresented: $viewModel.isImagePickerPresented) {
            ImagePicker(imageHandler: viewModel, selectedLimit: 1 - viewModel.selectedImageCount)
        }
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
                .onChange(of: viewModel.groupName) {
                    viewModel.groupName = limitText(viewModel.groupName, to: 10)
                }
        }
    }

    // MARK: - 텍스트 입력 제한 함수
    private func limitText(_ text: String, to limit: Int) -> String {
        return String(text.prefix(limit))
    }

    // MARK: - 그룹 이미지 선택
    private var groupImagePicker: some View {
        VStack(alignment: .leading, spacing: 21) {
            Text("그룹을 대표할 이미지를 설정해주세요")
                .font(.Subtitle3)
                .foregroundStyle(.g7)

            if let image = viewModel.groupImage {
                ZStack(alignment: .topTrailing) {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 214, height: 137)
                        .clipShape(RoundedRectangle(cornerRadius: 20))

                    Icon.close.image
                        .resizable()
                        .frame(width: 12, height: 12)
                        .background(
                            Circle()
                                .fill(Color.white)
                                .frame(width: 22, height: 22)
                        )
                        .foregroundStyle(.g7)
                        .offset(x: -12, y: 12)
                        .onTapGesture {
                            withAnimation {
                                viewModel.removeImage(at: 0) //  인덱스 추가
                            }
                        }
                }
            } else {
                Button(
                    action: {
                        viewModel.showImagePicker()
                    },
                    label:  {
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
                )
            }
        }
    }

    // MARK: - 캘린더 선택
    private var calendarSelection: some View {
        VStack(alignment: .leading, spacing: 21) {
            Text("모임 날짜를 선택해주세요")
                .font(.Subtitle3)
                .foregroundStyle(.g7)

            // 기존의 CreateCalenderView 유지
            CreateCalenderView(container: viewModel.container)
                       .onChange(of: viewModel.selectedDate) {
                           viewModel.promiseTime = formatDate(viewModel.selectedDate)
                       }

        }
    }


    // MARK: - 날짜 포맷 변환
    private func formatDate(_ date: Date) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.string(from: date)
    }
}

// MARK: - Preview
struct CreateGroupView_Previews: PreviewProvider {
    static var previews: some View {
        let container = DIContainer()
        let viewModel = CreateGroupViewModel(container: container)

        return CreateGroupView(container: container)
            .environmentObject(container)
            .environmentObject(viewModel)
    }
}
