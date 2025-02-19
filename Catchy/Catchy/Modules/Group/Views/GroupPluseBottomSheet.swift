//
//  GroupPluseBottomSheet.swift
//  Catchy
//
//  Created by 임소은 on 2/10/25.
//

import SwiftUI
import PhotosUI

struct GroupPluseBottomSheet: View {
    // MARK: - Properties
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var container: DIContainer
    @State private var isPhotoPickerPresented: Bool = false
    @State private var isQRCodeSheetPresented: Bool = false
    @State private var selectedImage: UIImage?
    @State private var selectedItem: PhotosPickerItem?

    // MARK: - Body
    var body: some View {
        VStack(spacing: 20) {
            header
            createGroupButton
            Divider()
            qrCodeButton
            Spacer()
        }
        .safeAreaPadding(EdgeInsets(top: 21, leading: 28, bottom: 0, trailing: 28))
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous)) 
        .presentationDetents([.fraction(0.3)])
        .confirmationDialog("QR코드로 참여하기", isPresented: $isQRCodeSheetPresented, titleVisibility: .visible) {
            qrCodeDialog
        }
        .sheet(isPresented: $isPhotoPickerPresented) {
            QRCodePickerView(selectedImage: $selectedImage)
        }
        .onChange(of: selectedItem) { _, newValue in
            loadSelectedImage(newValue)
        }
    }

    // MARK: - UI Components
    /// 상단 캡슐 바
    private var header: some View {
        Capsule()
            .fill(Color.g2)
            .frame(width: 49, height: 1)
    }

    /// 새 그룹 만들기 버튼
    private var createGroupButton: some View {
        Button(action: {
            dismiss()
            container.navigationRouter.push(to: .createGroupView)
        }) {
            HStack(spacing: 7) {
                Icon.voteStartButton.image.frame(width: 20, height: 20)
                Text("새 그룹 만들기").font(.body2).foregroundStyle(.g7)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 10)
    }

    /// QR 코드로 참여하기 버튼
    private var qrCodeButton: some View {
        Button(action: { isQRCodeSheetPresented = true }) {
            HStack(spacing: 7) {
                Icon.qrcodeIcon.image.frame(width: 18, height: 18)
                Text("QR코드로 참여하기").font(.body2).foregroundStyle(.g7)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 10)
    }

    /// QR 코드 액션 다이얼로그
    private var qrCodeDialog: some View {
        Group {
            Button("앨범에서 사진 선택") { isPhotoPickerPresented = true }
            Button("카메라 촬영하기") { openCamera() }
            Button("취소", role: .cancel) { }
        }
    }

    // MARK: - Functions
    /// 선택한 이미지를 로드하는 함수
    private func loadSelectedImage(_ newValue: PhotosPickerItem?) {
        Task {
            if let newValue, let data = try? await newValue.loadTransferable(type: Data.self),
               let image = UIImage(data: data) {
                selectedImage = image
            }
        }
    }

    /// 카메라 실행 함수
    private func openCamera() {
        //TODO: - 카메라 키는 함수 적용하기
    }


}

// MARK: - Preview
struct GroupPluseBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        GroupPluseBottomSheet()
            .environmentObject(DIContainer())
    }
}
