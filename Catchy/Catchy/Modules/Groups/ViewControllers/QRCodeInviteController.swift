
//
//  QRCodeInviteController.swift
//  Catchy
//
//  Created by 임소은 on 1/18/25.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

/// QR 코드 초대 로직을 처리하는 컨트롤러
class QRCodeInviteController: ObservableObject {
    // Published Properties for UI Binding
    @Published var inviteCode: String = ""
    @Published var userNickname: String = "초대 보내는 사람 닉네임"
    @Published var isLoading: Bool = true

    private let filter = CIFilter.qrCodeGenerator()

    // MARK: - Methods
    
    /// API연동 시뮬레이션
    /// 초대 코드를 설정
    func setupInviteCode() {
        // TODO: - 실제 API 연동을 추가하여 그룹 ID를 생성하고 초대 URL을 설정
    }

    
    /// QR 코드 이미지 생성
    func generateQRCode() -> UIImage? {
        let context = CIContext()
        filter.message = Data(inviteCode.utf8)
        if let outputImage = filter.outputImage,
           let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgImage)
        }
        return nil
    }
    
    /// QR 코드 공유
    func shareQRCode() {
        guard let qrImage = generateQRCode() else { return }
        let activityItems: [Any] = [qrImage]
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = scene.windows.first?.rootViewController {
            rootViewController.present(activityViewController, animated: true)
        }
    }
    
    /// QR 코드 저장
    func saveQRCode() {
        guard let qrImage = generateQRCode() else { return }
        UIImageWriteToSavedPhotosAlbum(qrImage, nil, nil, nil)
    }
    
    /// 페이지 닫기
    func closePage() {
        // 페이지를 닫는 동작 구현
    }
}
