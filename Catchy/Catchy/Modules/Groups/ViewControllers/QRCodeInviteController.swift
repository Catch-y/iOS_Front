
//
//  QRCodeInviteController.swift
//  Catchy
//
//  Created by 임소은 on 1/18/25.
//


import SwiftUI
import CoreImage.CIFilterBuiltins

class QRCodeInviteController: ObservableObject {
    @Published var inviteCode: String = "" // 초대 URL
    @Published var userNickname: String = "초대 보내는 사람 닉네임" // 초대 보내는 사용자의 닉네임
    @Published var isLoading: Bool = true
    @Published var qrCodeImage: UIImage? // QR 코드 이미지

    private let filter = CIFilter.qrCodeGenerator()

    // MARK: - Methods

    /// API 연동 시뮬레이션
    func setupInviteCode() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // TODO: - 실제 API 연동을 추가하여 그룹 ID를 생성하고 초대 URL을 설정
            self.inviteCode = "https://developer.apple.com/documentation/coreimage/ciqrcodefeature" // 초대 URL 설정
            self.qrCodeImage = self.generateQRCodeWithRepresentImage(from: self.inviteCode) // QR 코드 생성
            self.userNickname = "김캐치" // 초대 보내는 사용자 닉네임 설정
            self.isLoading = false
        }
    }

    /// QR 코드 생성 함수
    private func generateQRCode(from string: String) -> UIImage? {
        guard !string.isEmpty else { return nil }

        let context = CIContext()
        filter.message = Data(string.utf8)

        guard let outputImage = filter.outputImage else { return nil }
        let scaledQRImage = outputImage.transformed(by: CGAffineTransform(scaleX: 10, y: 10))

        guard let cgImage = context.createCGImage(scaledQRImage, from: scaledQRImage.extent) else { return nil }
        return UIImage(cgImage: cgImage)
    }

    /// QR 코드 생성 시 그룹대표이미지 삽입
    private func generateQRCodeWithRepresentImage(from string: String) -> UIImage? {
        guard let qrImage = generateQRCode(from: string),
              let representImage = UIImage(named: "groupImage") else { return generateQRCode(from: string) }

        return embedRepresentImageInQRCode(qrImage: qrImage, representImageRect: representImage)
    }

    private func embedRepresentImageInQRCode(qrImage: UIImage, representImageRect: UIImage) -> UIImage? {
        let size = qrImage.size

        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)

        // QR 코드 그리기
        qrImage.draw(in: CGRect(origin: .zero, size: size))

        //그룹 대표 이미지
        let representImageSize = CGSize(width: size.width * 0.2, height: size.height * 0.2)
        let margin: CGFloat = size.width * 0.05
        let backgroundSize = CGSize(width: representImageSize.width + margin, height: representImageSize.height + margin)

        // 대표 이미지와 QR코드 사이에 거리 두기
        let backgroundOrigin = CGPoint(
            x: (size.width - backgroundSize.width) / 2,
            y: (size.height - backgroundSize.height) / 2
        )
        let backgroundRect = CGRect(origin: backgroundOrigin, size: backgroundSize)

        UIColor.white.setFill()
        UIBezierPath(ovalIn: backgroundRect).fill()

        // 그룹대표이미지 원형으로 클립
        let representImageOrigin = CGPoint(
            x: backgroundOrigin.x + margin / 2,
            y: (backgroundOrigin.y + margin / 2)
        )
        let representImageFrame = CGRect(origin: representImageOrigin, size: representImageSize)

        let path = UIBezierPath(ovalIn: representImageFrame)
        path.addClip()
        representImageRect.draw(in: representImageFrame)

        let combinedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return combinedImage
    }

    /// QR 코드 공유
    func shareQRCode() {
        guard let qrImage = qrCodeImage else { return }
        let activityItems: [Any] = [qrImage]
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)

        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = scene.windows.first?.rootViewController {
            rootViewController.present(activityViewController, animated: true)
        }
    }

    /// QR 코드 저장
    func saveQRCode() {
        guard let qrImage = qrCodeImage else { return }
        UIImageWriteToSavedPhotosAlbum(qrImage, nil, nil, nil)
    }

    /// 페이지 닫기
    func closePage() {

        // TODO: - 페이지 닫기 동작 구현
    }
}

