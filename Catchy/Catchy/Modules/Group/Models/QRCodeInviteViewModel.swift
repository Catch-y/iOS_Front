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
    @Published var inviteCode: String = ""
    @Published var userNickname: String = "초대 보내는 사람 닉네임"
    @Published var isLoading: Bool = true
    @Published var qrCodeImage: UIImage?

    let container: DIContainer
    private let filter = CIFilter.qrCodeGenerator()
    
    // Moya provider – stubClosure를 이용해 sampleData를 즉시 반환하도록 설정
    private let provider = MoyaProvider<GroupAPITarget>(stubClosure: MoyaProvider.immediatelyStub)

    // MARK: - 초기화
    init(container: DIContainer) {
        self.container = container
    }
    
    // MARK: - 서버 연동: 그룹 생성 및 초대 URL, 그룹 정보 받아오기
    func setupInviteCode() {
       
        // 그룹 생성 시 필요한 정보 (필요에 따라 값을 동적으로 변경)
        let group = GroupInfo(
            groupName: "Study Group",
            groupLocation: "Seoul",
            promiseTime: "2025-02-20T05:08:03.006Z",
            groupImage: "https://i.pinimg.com/474x/1a/e2/8f/1ae28fe7bd5e3211be36f7a48b976226.jpg"
        )
      
        
        provider.request(.postCreateGroup(group: group)) { result in
            switch result {
            case .success(let response):
                print("서버 응답 수신됨: \(response.statusCode)")
                do {
                    let decoder = JSONDecoder()
                    let createGroupResponse = try decoder.decode(CreateGroupResponse.self, from: response.data)
                    print("디코딩 성공: \(createGroupResponse)")
                    
                    // 응답의 result가 존재하면 데이터를 업데이트
                    if let groupResult = createGroupResponse.result {
                        DispatchQueue.main.async {
                            self.inviteCode = groupResult.inviteCode
                            self.userNickname = groupResult.creatorNickname
                            // QR 코드 생성 (대표 이미지 삽입 함수 호출)
                            self.qrCodeImage = self.generateQRCodeWithRepresentImage(from: self.inviteCode)
                            self.isLoading = false
                            print("초대 코드: \(self.inviteCode), 생성자 닉네임: \(self.userNickname)")
                            print("QR 코드 이미지 생성 완료")
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.isLoading = false
                            print("서버 응답에 result 값이 없습니다.")
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.isLoading = false
                        print("디코딩 에러: \(error)")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isLoading = false
                    print("네트워크 에러: \(error)")
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
    
    // MARK: - QR 코드 공유
    func shareQRCode() {
        guard let qrImage = qrCodeImage else { return }
        let activityItems: [Any] = [qrImage]
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(activityViewController, animated: true)
        }
    }
    
    // MARK: - QR 코드 저장
    func saveQRCode() {
        guard let qrImage = qrCodeImage else { return }
        UIImageWriteToSavedPhotosAlbum(qrImage, nil, nil, nil)
    }
    
    // MARK: - 페이지 닫기
    func closePage() {
        // TODO: - 페이지 닫기 동작 구현
       
    }
}
