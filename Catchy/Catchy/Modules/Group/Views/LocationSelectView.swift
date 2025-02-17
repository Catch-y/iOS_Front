//
//  LocationSelectView.swift
//  Catchy
//
//  Created by 임소은 on 2/12/25.
//

import SwiftUI

struct LocationSelectView: View {
    @StateObject private var viewModel: LocationSelectViewModel

    // MARK: - 초기화
    init(container: DIContainer) {
        _viewModel = StateObject(wrappedValue: .init(container: container))
    }

    var body: some View {
        VStack {
            GroupNavigation(title: "새 그룹 만들기") {
                print("뒤로가기 버튼 클릭")
            }

            ScrollView {
                VStack(alignment: .leading) {
                    stepIndicatorView()
                        .padding(.top, 35)

                    selectedLocationText() // 선택한 지역 텍스트 추가

                    VStack(alignment: .leading, spacing: 20) {
                        Text("방문하실 지역을 선택해주세요")
                            .font(.Subtitle1)
                            .padding(.top, 31)
                        Text("상위 지역을 선택해주세요")
                            .font(.body2)
                    }

                    if viewModel.locations.isEmpty {
                        ProgressView() // 로딩 인디케이터
                            .frame(height: 100)
                            .padding(.top, 20)
                    } else {
                        locationGridView()
                            .padding(.top, 20)
                    }

                    MainBtn(
                        text: "다음",
                        action: {
                            print("다음 버튼 클릭")
                        },
                        width: UIScreen.main.bounds.width - 32,
                        height: 60,
                        onoff: (viewModel.selectedLocation ?? "").isEmpty ? .off : .on
                    )
                    .padding(.top, 38)
                }
                .padding(.horizontal, 16)
            }
        }
        .task {
            if viewModel.locations.isEmpty {
                viewModel.fetchLocations() // 비동기 작업 실행
            }
        }
    }

    // MARK: - 선택한 지역 표시
    private func selectedLocationText() -> some View {
        Text(viewModel.selectedLocation ?? " ")
            .font(.caption)
            .foregroundStyle(.m5)
            .opacity(viewModel.selectedLocation == nil ? 0 : 1) // 선택되지 않으면 숨김
    }

    // MARK: - 지역 선택 그리드
    private func locationGridView() -> some View {
        LazyVStack(alignment: .leading, spacing: 16) {
            ForEach(viewModel.locations.chunked(into: 3), id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(row, id: \.self) { location in
                        LocationButton(
                            title: location,
                            isSelected: .constant(location == viewModel.selectedLocation),
                            action: {
                                viewModel.selectedLocation = location
                            }
                        )
                        .frame(width: (UIScreen.main.bounds.width - 52) / 3, height: 55) // 버튼 크기 균등하게 조정
                    }
                }
            }
        }
    }

    // MARK: - 상단 1 .. 2 뷰
    private func stepIndicatorView() -> some View {
        HStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(Color("m5")) // 핑크색 (활성 상태)
                    .frame(width: 26, height: 26)
                Text("1")
                    .font(.Subtitle2)
                    .foregroundStyle(.white)
            }

            HStack(spacing: 4) {
                ForEach(0..<3) { _ in
                    Circle()
                        .fill(Color("g2")) // 회색 점
                        .frame(width: 3, height: 3)
                }
            }

            ZStack {
                Circle()
                    .stroke(Color("g3"), lineWidth: 1)
                    .frame(width: 26, height: 26)
                Text("2")
                    .font(.Subtitle2)
                    .foregroundStyle(Color("g2"))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


// MARK: - Chunked
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
        let container = DIContainer()
        return LocationSelectView(container: container)
            .previewLayout(.sizeThatFits)
    }
}
