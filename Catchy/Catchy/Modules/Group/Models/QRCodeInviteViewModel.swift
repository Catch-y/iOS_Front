//
//  QRCodeInviteViewModel.swift
//  Catchy
//
//  Created by 임소은 on 2/12/25.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
import Moya

class QRCodeInviteViewModel: ObservableObject {
    @Published var groupInfo: GroupInfo
    @Published var inviteCode: String?
    @Published var userNickname: String = "초대 보내는 사람 닉네임"
    @Published var isLoading: Bool = true
    @Published var qrCodeImage: UIImage?

    let container: DIContainer
    

    
    private let filter = CIFilter.qrCodeGenerator()
    private let provider: MoyaProvider<GroupAPITarget>
    
    // MARK: - 초기화
    init(container: DIContainer,
         provider: MoyaProvider<GroupAPITarget> = MoyaProvider<GroupAPITarget>(),
         groupInfo: GroupInfo) { // ✅ groupInfo 추가
        self.container = container
        self.provider = provider
        self.groupInfo = groupInfo // ✅ 전달받은 그룹 정보 저장
    }

    // MARK: - 서버 연동: 그룹 생성 및 초대 URL, 그룹 정보 받아오기
    func setupInviteCode() {
        let group = GroupInfo(
            groupName: "Study Group",
            groupLocation: ["서울특별시", "광진구"],
            promiseTime: "2025-02-20T05:08:03.006Z",
            groupImage: "https://i.pinimg.com/474x/1a/e2/8f/1ae28fe7bd5e3211be36f7a48b976226.jpg"
        )

        // ✅ AccessToken 확인 (로그 추가)
        let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? "없음"
        print("📌 현재 AccessToken: \(accessToken)")

        let headers: [String: String] = [
            "Authorization": "Bearer \(accessToken)"
        ]
        print("📌 API 요청 헤더: \(headers)")

        provider.request(.postCreateGroup(group: group)) { result in
            switch result {
            case .success(let response):
                print("✅ 서버 응답 수신됨: \(response.statusCode)")
                do {
                    let decoder = JSONDecoder()
                    let createGroupResponse = try decoder.decode(CreateGroupResponse.self, from: response.data)
                    print("✅ 디코딩 성공: \(createGroupResponse)")

                    if let groupResult = createGroupResponse.result {
                                    DispatchQueue.main.async {
                                        // ✅ 서버에서 받은 groupId로 업데이트
                                        self.groupInfo = GroupInfo(
                                            groupId: groupResult.groupId,
                                            groupName: self.groupInfo.groupName,
                                            groupLocation: self.groupInfo.groupLocation,
                                            promiseTime: self.groupInfo.promiseTime,
                                            groupImage: self.groupInfo.groupImage,
                                            inviteCode: groupResult.inviteCode
                                        )
                                        self.inviteCode = groupResult.inviteCode
                                        self.userNickname = groupResult.creatorNickname
                                        self.qrCodeImage = self.generateQRCodeWithRepresentImage(from: self.inviteCode ?? "DEFAULT")
                                        self.isLoading = false

                                        print("✅ 그룹이 성공적으로 생성되었습니다. 그룹 ID: \(groupResult.groupId)")
                                    }
                    } else {
                        DispatchQueue.main.async {
                            self.isLoading = false
                            print("⚠️ 서버 응답에 result 값이 없습니다.")
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.isLoading = false
                        print("❌ 디코딩 에러: \(error)")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isLoading = false
                    print("❌ 네트워크 에러: \(error)")
                }
            }
        }
    }

    
    // MARK: - QR 코드 생성 함수
    private func generateQRCode(from string: String) -> UIImage? {
        guard !string.isEmpty else { return nil }
        let context = CIContext()
        filter.message = Data(string.utf8)
        
        guard let outputImage = filter.outputImage else { return nil }
        let scaledQRImage = outputImage.transformed(by: CGAffineTransform(scaleX: 10, y: 10))
        
        guard let cgImage = context.createCGImage(scaledQRImage, from: scaledQRImage.extent) else { return nil }
        return UIImage(cgImage: cgImage)
    }
    
    /// 그룹 대표 이미지를 QR 코드 중앙에 삽입하여 최종 QR 이미지 생성
    private func generateQRCodeWithRepresentImage(from string: String) -> UIImage? {
        guard let qrImage = generateQRCode(from: string),
              let representImage = UIImage(named: "groupImage") else {
            return generateQRCode(from: string)
        }
      
        return embedRepresentImageInQRCode(qrImage: qrImage, representImageRect: representImage)
    }
    
    private func embedRepresentImageInQRCode(qrImage: UIImage, representImageRect: UIImage) -> UIImage? {
        let size = qrImage.size
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        qrImage.draw(in: CGRect(origin: .zero, size: size))
        
        let representImageSize = CGSize(width: size.width * 0.2, height: size.height * 0.2)
        let margin: CGFloat = size.width * 0.05
        let backgroundSize = CGSize(width: representImageSize.width + margin, height: representImageSize.height + margin)
        
        let backgroundOrigin = CGPoint(
            x: (size.width - backgroundSize.width) / 2,
            y: (size.height - backgroundSize.height) / 2
        )
        let backgroundRect = CGRect(origin: backgroundOrigin, size: backgroundSize)
        
        UIColor.white.setFill()
        UIBezierPath(ovalIn: backgroundRect).fill()
        
        let representImageOrigin = CGPoint(
            x: backgroundOrigin.x + margin / 2,
            y: backgroundOrigin.y + margin / 2
        )
        let representImageFrame = CGRect(origin: representImageOrigin, size: representImageSize)
        
        let path = UIBezierPath(ovalIn: representImageFrame)
        path.addClip()
        representImageRect.draw(in: representImageFrame)
        
        let combinedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return combinedImage
    }
    
    
    // MARK: - QR 코드 저장
    func saveQRCode() {
        guard let qrImage = qrCodeImage else { return }
        UIImageWriteToSavedPhotosAlbum(qrImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    // 저장 완료 여부 확인
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if error == nil {
            print("이미지 저장 성공!")
        }
    }
}
