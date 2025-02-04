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
    @Binding var isSelected: Bool // 버튼의 선택 상태를 상위 뷰로부터 전달받도록
    
    init(title: String, isSelected: Binding<Bool>, action: @escaping () -> Void) {
            self.title = title
            self._isSelected = isSelected // Binding으로 전달된 값을 초기화
            self.action = action
        }
        
    
    
    var body: some View {
            Button(action: {
                isSelected.toggle() // 선택 상태 변경
                action() // 상위에서 전달된 액션 호출
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
            .font(.body2)
            .foregroundStyle(isSelected ? Color.m6 : Color.g4)//글씨 색깔
            .frame(width: 118, height: 55) // 버튼 크기
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

