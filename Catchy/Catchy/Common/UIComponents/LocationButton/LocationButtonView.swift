import SwiftUI

// MARK: - LocationButtonView
struct LocationButtonView: View {
    let model: LocationButtonModel // 버튼 데이터
    @State private var isSelected: Bool = false // 버튼의 선택 상태를 관리
    
    var body: some View {
        Button(action: {
            isSelected.toggle() // 버튼 클릭 시 상태 변경
        }) {
            buttonContent()
        }
        .buttonStyle(PlainButtonStyle())
        
    }
}

// MARK: - Private Extension
private extension LocationButtonView {
    /// 버튼의 UI를 구성하는 메서드
    func buttonContent() -> some View {
        Text(model.title)
            .font(.custom("Medium", size: 13))
            .foregroundStyle(isSelected ? Color.m6 : Color.g4)
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
            LocationButtonView(
                model: LocationButtonModel(
                    title: "서울시"
                )
            )
          
        }
    }
}

