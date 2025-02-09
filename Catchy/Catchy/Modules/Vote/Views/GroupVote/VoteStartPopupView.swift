//
//  VoteStartPopupView.swift
//  Catchy
//
//  Created by 임소은 on 2/5/25.
//

import SwiftUI

struct VoteStartPopupView: View {
    @Binding var isPresented: Bool

    // MARK: - Body
    var body: some View {
        ZStack {
            if isPresented {
                Color.bg1
                    .edgesIgnoringSafeArea(.all) // 화면 덮는 거
                    .onTapGesture { isPresented = false }

                popupContent
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                        
                    )
                    .padding(.horizontal, 40)
            }
        }
        .animation(.easeInOut, value: isPresented)
    }

    // MARK: - 팝업창
    private var popupContent: some View {
        VStack(spacing: 20) {
            closeButton // 닫기 버튼
                .padding(.trailing, 16)

            VStack(spacing: 45) {
                messageText // 텍스트
                actionButton // 투표 참여하기 버튼
            }
            .frame(maxWidth: .infinity) // 가운데 정렬
        }
    }

    // MARK: - 닫기 버튼
    private var closeButton: some View {
        HStack {
            Spacer()
            Button(action: { isPresented = false }) {
                Icon.close.image
            }
        }
    }

    // MARK: - Message Text
    private var messageText: some View {
        Text("투표가 생성되었습니다!\n지금 바로 투표에 참여해보세요!")
            .font(.Subtitle3)
            .multilineTextAlignment(.center)
            .foregroundStyle(.g7)
    }

    // MARK: - Action Button
    private var actionButton: some View {
        Button(action: { print("투표 참여하기 클릭됨") }) {
            Text("투표 참여하기")
                .font(.Subtitle3)
                .foregroundStyle(.m5)
                .frame(maxWidth: .infinity)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.m5, lineWidth: 1)
                )
        }
        .padding(.horizontal, 40)
    }
}

struct VoteStartPopupView_Previews: PreviewProvider {
    static var previews: some View {
        VoteStartPopupView(isPresented: .constant(true))
    }
}
