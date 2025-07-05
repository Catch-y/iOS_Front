//
//  QRCodeInviteView.swift
//  Catchy
//
//  Created by 임소은 on 2/12/25.
//

//FIXME: - QR sharing buttton 수정 


import SwiftUI

struct QRCodeInviteView: View {
    
    @EnvironmentObject var container: DIContainer
    
    @StateObject private var viewModel: QRCodeInviteViewModel
    @State private var showToast: Bool = false // 토스트 알림

    // MARK: - 초기화
    init(container: DIContainer, groupInfo: GroupInfo) {
        _viewModel = StateObject(wrappedValue: QRCodeInviteViewModel(container: container, groupInfo: groupInfo))
        
        _ = groupInfo.groupImage?.prefix(50) ?? "nil" 
        print("""
        🟢 QRCodeInviteView에서 받은 groupInfo:
            🔹 groupId: \(groupInfo.groupId ?? -1)
            🔹 groupName: \(groupInfo.groupName)
            🔹 groupLocation: \(groupInfo.groupLocation.joined(separator: ", "))
            🔹 promiseTime: \(groupInfo.promiseTime)
            🔹 inviteCode: \(groupInfo.inviteCode ?? "없음")
            🔹 imageURL: \(groupInfo.groupImage?.prefix(50) ?? "없음")...
        """)


    }

    var body: some View {
        VStack(spacing: 0) {
            topCloseButton()

            Spacer()

            if viewModel.isLoading {
                ProgressView("QR 코드를 생성 중입니다")
                    .padding()
            } else if let qrImage = viewModel.qrCodeImage {
                qrCodeContent(qrImage: qrImage)
            } else {
                Text("QR 코드를 생성할 수 없습니다.")
                    .font(.body3)
            }

            if !viewModel.isLoading {
                bottomButtons()
            }

            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            viewModel.setupInviteCode()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.ignoresSafeArea())
        .overlay(toastView())
    }

    // MARK: - 닫기 버튼
    private func topCloseButton() -> some View {
        HStack {
            Spacer()
            Button(action: {
                    container.navigationRouter.popToRootView() //  네비게이션 스택 비우기

            }) {
                Icon.close.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
            .frame(width: 24, height: 24)
            .contentShape(Rectangle())
        }
        .padding(.top, 20)
        .padding(.horizontal, 29)
    }

    // MARK: - QR 코드 및 닉네임
    private func qrCodeContent(qrImage: UIImage) -> some View {
        VStack(spacing: 10) {
            Text(viewModel.userNickname)
                .font(.Subtitle3)
                .foregroundStyle(Color.g7)

            Image(uiImage: qrImage)
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }

    // MARK: - 외부공유, QR다운 버튼
    private func bottomButtons() -> some View {
        HStack(spacing: 15) {
            if let inviteCode = viewModel.inviteCode {
                ShareLink(
                    item: URL(string: "https://초대링크.com/invite/\(inviteCode)")!,
                    preview: SharePreview(Text("📎 초대 코드: \(inviteCode)"))
                ) {
                    VStack {
                        Icon.shareButton.image
                            .resizable()
                            .frame(width: 42, height: 42)
                        Text("외부공유")
                            .font(.body3)
                            .foregroundStyle(Color.g5)
                    }
                }
            } else {
                VStack {
                    Icon.shareButton.image
                        .resizable()
                        .frame(width: 42, height: 42)
                    Text("외부공유")
                        .font(.body3)
                        .foregroundStyle(Color.g5)
                }
            }

            Button(action: {
                viewModel.saveQRCode()
                showToast = true
            }) {
                VStack {
                    Icon.downButton.image
                        .resizable()
                        .frame(width: 42, height: 42)
                    Text("QR저장")
                        .font(.body3)
                        .foregroundStyle(Color.g5)
                }
            }
        }
        .padding(.top, 12)
    }
    // MARK: - 토스트 메시지 뷰
       private func toastView() -> some View {
           VStack {
               Spacer()
               if showToast {
                   Text("📷 사진이 저장되었습니다")
                       .padding()
                       .background(Color.gray.opacity(0.3))
                       .foregroundStyle(.white)
                       .cornerRadius(20)
                       .transition(.opacity)
                       .onAppear {
                           DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                               withAnimation {
                                   showToast = false
                               }
                           }
                       }
               }
           }
           .padding(.bottom, 50)
       }

    }

// MARK: - Preview
struct QRCodeInviteView_Previews: PreviewProvider {
    static var previews: some View {
        let container = DIContainer()
        let sampleGroupInfo = GroupInfo(
            groupName: "Sample Group",
            groupLocation: ["서울특별시","광진구"],
            promiseTime: "2025-02-20T05:08:03.006Z",
            groupImage: "https://i.pinimg.com/474x/1a/e2/8f/1ae28fe7bd5e3211be36f7a48b976226.jpg"
        )
        return QRCodeInviteView(container: container, groupInfo: sampleGroupInfo)
    }
}
