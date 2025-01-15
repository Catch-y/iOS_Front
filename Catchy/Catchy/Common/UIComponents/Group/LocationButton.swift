//
//  Location.swift
//  Catchy
//
//  Created by 임소은 on 1/15/25.
//

import SwiftUI

// MARK: - LocationButton
struct LocationButton: View {
    let title: String // 버튼 내부 텍스트 값
    let action: () -> Void // 버튼 액션 처리 클로저
    @State private var isSelected: Bool = false // 버튼의 선택 상태를 관리
    
 
    init(title: String, action: @escaping () -> Void = {}) {
        self.title = title
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            isSelected.toggle() // 버튼 선택 상태 변경
            action()
        }) {
            buttonContent() // 버튼 UI를 구성하는 메서드
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Private Extension
private extension LocationButton {
    /// 버튼의 UI를 구성하는 메서드
    func buttonContent() -> some View {
        Text(title)
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(isSelected ? Color.m6 : Color.g4) //글씨 색깔
            .frame(width: 118, height: 55) // 고정된 버튼 크기
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isSelected ? Color.m6 : Color.g3, lineWidth: 1) // 테두리 색상
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(isSelected ? Color.m1 : Color.white) // 배경 색상
                    )
            )
    }
}

// MARK: - Preview
struct LocationButtonView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            LocationButton(title: "서울시")
            LocationButton(title: "경기도")
            LocationButton(title: "인천")
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
