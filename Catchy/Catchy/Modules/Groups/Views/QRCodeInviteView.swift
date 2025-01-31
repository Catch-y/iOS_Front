import SwiftUI

struct QRCodeInviteView: View {
    @ObservedObject var controller: QRCodeInviteController

    var body: some View {
        VStack(spacing: 0) {
            topCloseButton()

            Spacer()

            if controller.isLoading {
                ProgressView("QR 코드를 생성 중입니다")
                    .padding()
            } else if let qrImage = controller.qrCodeImage {
                qrCodeContent(qrImage: qrImage)
            } else {
                Text("QR 코드를 생성할 수 없습니다.")
                    .font(.body3)
            }

            if !controller.isLoading {
                bottomButtons()
            }

            Spacer()
        }
        .onAppear(perform: controller.setupInviteCode) // 화면이 나타날 때 초대 코드 설정
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.ignoresSafeArea())
    }

    // MARK: - 닫기 버튼
    private func topCloseButton() -> some View {
        HStack {
            Spacer()
            Button(action: {
                controller.closePage()
            }) {
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color.g4)
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
            // 초대하는 사용자의 닉네임 텍스트
            Text(controller.userNickname)
                .font(.Subtitle3)
                .foregroundStyle(Color.g7)

            // QR 코드 이미지
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
                controller.shareQRCode()
            }) {
                VStack {
                    Image("shareButton")
                        .resizable()
                        .frame(width: 42, height: 42)
                    Text("외부공유")
                        .font(.body3)
                        .foregroundStyle(Color.g5)
                }
            }

            Button(action: {
                controller.saveQRCode()
            }) {
                VStack {
                    Image("downButton")
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
        let controller = QRCodeInviteController()
        controller.isLoading = false
        controller.inviteCode = "https://developer.apple.com/documentation/coreimage/ciqrcodefeature"
        controller.userNickname = "김캐치"

        return QRCodeInviteView(controller: controller)
    }
}

