//
//  Untitled.swift
//  Catchy
//
//  Created by 임소은 on 1/18/25.
//

import SwiftUI

/// QR 코드 초대 뷰
struct QRCodeInviteView: View {
    // Controller에서 전달된 데이터를 상태로 관리
    @ObservedObject var controller: QRCodeInviteController

    var body: some View {
        VStack(spacing: 0) {
            // 닫기 버튼
            topCloseButton()
            
            Spacer()
            
            // 사용자 닉네임 및 로딩 상태
            if controller.isLoading {
                ProgressView("QR 코드를 생성 중입니다")
                    .padding()
            } else {
                Text(controller.userNickname)
                    .font(.Subtitle3)
                    .foregroundStyle(Color.black)
                    .padding(.bottom, 10)
            }
            
            // QR 코드 이미지
            if !controller.isLoading, !controller.inviteCode.isEmpty {
                qrCodeImage()
            }
            
            // 공유 및 저장 버튼
            if !controller.isLoading {
                bottomButtons()
            }
            
            Spacer()
        }
        .onAppear(perform: controller.setupInviteCode) // 화면이 나타날 때 초대 코드 설정
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.ignoresSafeArea())
    }
    
    
    // MARK: - Private Views
    
    //닫기버튼
    private func topCloseButton() -> some View {
        HStack {
            Spacer()
            Button(action: {
                controller.closePage()
            }) {
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(Color.gray)
                    .padding()
                    
            }
            .frame(width: 24, height: 24)
            .contentShape(Rectangle())
        }
        .padding(.top, 20)
        .padding(.trailing, 29)
    }
    
    //QR코드 이미지
    private func qrCodeImage() -> some View {
        if let qrImage = controller.generateQRCode() {
            return AnyView(
                Image(uiImage: qrImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 290)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()
            )
        } else {
            return AnyView(
                Text("QR 코드를 생성할 수 없습니다.")
                    .foregroundStyle(Color.red)
            )
        }
    }
    
    //외부공유, QR다운 버튼
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
                        .foregroundStyle(Color.gray)
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
                        .foregroundStyle(Color.gray)
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
        controller.isLoading = false // 로딩 완료 상태로 설정
        controller.inviteCode = "https://developer.apple.com/documentation/coreimage/" // 미리 보기 초대 코드
        controller.userNickname = "초대 보내는 사람 닉네임" // 미리 보기 닉네임
        
        return QRCodeInviteView(controller: controller)
            
    }
}


