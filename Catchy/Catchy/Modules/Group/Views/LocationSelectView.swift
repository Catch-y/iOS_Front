import SwiftUI

// TODO: - 네비게이션 추가


struct LocationSelectView: View {
    @State private var selectedTitle: String? // 현재 선택된 버튼의 타이틀
    
    let locations = [
        "서울시", "경기도", "인천", "울산", "부산", "대구",
        "광주", "대전", "세종시", "강원도", "충청북도", "충청남도",
        "전북", "전남", "경북", "경남", "제주도"
    ] // 버튼 목록
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                // 상단 뷰: 1 .. 2 디자인
                stepIndicatorView()
                    .padding(.top, 35)
                
                // 설명 텍스트
                VStack(alignment: .leading, spacing: 10) {
                    Text("방문하실 지역을 선택해주세요")
                        .font(.Subtitle1)
                        .padding(.top, 49)
                    Text("상위 지역을 선택해주세요")
                        .font(.body2)
                        .padding(.top, 20)
                }
                
                // 지역 선택 버튼 그리드
                    locationGridView()
                        .padding(.top, 20)
            }
            .padding(.horizontal, 16) // 좌우 패딩 추가
            
        }
        
    }
    
    // MARK: - 지역 선택 그리드
        private func locationGridView() -> some View {
            LazyVStack(alignment: .leading, spacing: 16) { // 행 간격 및 왼쪽 정렬
                ForEach(locations.chunked(into: 3), id: \.self) { row in
                    HStack(spacing: 10) { // 버튼 간격
                        ForEach(row, id: \.self) { location in
                            // LocationButton 사용
                            LocationButton(
                                title: location,
                                isSelected: .constant(location == selectedTitle),
                                action: {
                                    // 선택된 버튼 업데이트
                                    selectedTitle = location
                                }
                            )
                            .frame(width: 118, height: 55) // 버튼 크기 고정
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading) // LazyVStack 전체 크기 및 정렬 설정
        }
    
    // MARK: - 상단 1 .. 2 뷰
    private func stepIndicatorView() -> some View {
        HStack(spacing: 10) {
            // "1" 적힌 원
            ZStack {
                Circle()
                    .fill(Color("m5")) // 핑크색 (활성 상태)
                    .frame(width: 26, height: 26)
                Text("1")
                    .font(.ButtonText)
                    .foregroundStyle(.white)
            }
            
            // ... 점
            HStack(spacing: 4) {
                ForEach(0..<3) { _ in
                    Circle()
                        .fill(Color("g2")) // 회색 점
                        .frame(width: 3, height: 3)
                }
            }
            
            // "2" 적힌 원
            ZStack {
                Circle()
                    .stroke(Color("g3"), lineWidth: 1) // 회색 테두리
                    .frame(width: 26, height: 26)
                Text("2")
                    .font(.ButtonText)
                    .foregroundStyle(Color("g2")) // 회색 텍스트
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading) // HStack 왼쪽 정렬
    }
}

// MARK: - Array Extension for Chunking
extension Array {
    /// 주어진 크기로 배열을 나눕니다.
    func chunked(into size: Int) -> [[Element]] {
        var chunks: [[Element]] = []
        for index in stride(from: 0, to: self.count, by: size) {
            let chunk = Array(self[index..<Swift.min(index + size, self.count)])
            chunks.append(chunk)
        }
        return chunks
    }
}

// MARK: - Preview
struct LocationSelectView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSelectView()
            .previewLayout(.sizeThatFits)
    }
}

