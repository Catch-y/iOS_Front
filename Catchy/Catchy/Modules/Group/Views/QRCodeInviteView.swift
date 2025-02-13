//
//  QRCodeInviteView.swift
//  Catchy
//
//  Created by 임소은 on 2/12/25.
//

import SwiftUI

struct QRCodeInviteView: View {
    @StateObject private var viewModel: QRCodeInviteViewModel

    // MARK: - 초기화
    init(container: DIContainer) {
        _viewModel = StateObject(wrappedValue: QRCodeInviteViewModel(container: container)) 
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
        .task {
            viewModel.setupInviteCode()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.ignoresSafeArea())
    }

    // MARK: - 닫기 버튼
    private func topCloseButton() -> some View {
        HStack {
            Spacer()
            Button(action: {
                viewModel.closePage()
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
            Button(action: {
                viewModel.shareQRCode()
            }) {
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
}

// MARK: - Preview
struct QRCodeInviteView_Previews: PreviewProvider {
    static var previews: some View {
        let container = DIContainer()
        return QRCodeInviteView(container: container)
    }
}
