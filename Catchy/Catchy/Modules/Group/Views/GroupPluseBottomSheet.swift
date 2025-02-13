//
//  GroupPluseBottomSheet.swift
//  Catchy
//
//  Created by 임소은 on 2/10/25.
//

import SwiftUI

// MARK: - GroupPluseBottomSheet
/// 그룹 생성 및 QR코드 참여 바텀시트 뷰
struct GroupPluseBottomSheet: View {
    // MARK: - Properties
    @Environment(\.dismiss) private var dismiss // 바텀시트 닫기

    var body: some View {
        VStack(spacing: 20) {
            // 바텀시트 상단 제목
            Text("그룹 생성하기")
                .font(.Subtitle3)
                .padding(.top, 30)

            // 새 그룹 만들기 버튼
            Button(action: {
                print("새 그룹 만들기 클릭됨")
            }) {
                HStack(spacing: 7) {
                    Icon.voteStartButton.image
                        .frame(width: 20, height: 20)
                        
                    Text("새 그룹 만들기")
                        .font(.body2)
                        .foregroundStyle(.g7)
                }
                .frame(maxWidth: .infinity, alignment: .leading) // 왼쪽 정렬
            }
            .padding(.vertical, 10)

            Divider()

            // QR코드로 참여하기 버튼
            Button(action: {
                print("QR코드로 참여하기 클릭됨")
            }) {
                HStack(spacing: 7) {
                    Icon.qrcodeIcon.image
                        .frame(width: 18, height: 18)
                        
                    Text("QR코드로 참여하기")
                        .font(.body2)
                        .foregroundStyle(.g7)
                }
                .frame(maxWidth: .infinity, alignment: .leading) // 왼쪽 정렬
            }
            .padding(.vertical, 10)

            Spacer()
        }
        .padding()
        .background(Color.white)
        .presentationDetents([.fraction(0.4), .medium]) // 바텀시트 높이 설정
    }
}

// MARK: - Preview
struct GroupPluseBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        GroupPluseBottomSheet()
    }
}
