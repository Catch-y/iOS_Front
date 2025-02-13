//
//  SubLocationSelectView.swift
//  Catchy
//
//  Created by 임소은 on 2/12/25.
//

import SwiftUI

struct SubLocationSelectView: View {
    @StateObject private var viewModel: SubLocationSelectViewModel
    let selectedLocation: String //  상위 지역 저장

    // MARK: - 초기화
    init(container: DIContainer, selectedLocation: String) {
        _viewModel = StateObject(wrappedValue: .init(container: container))
        self.selectedLocation = selectedLocation //  선택된 상위 지역 저장
    }

    let sublocations = [
        "강남구", "종로구", "중구",
        "용산구", "성동구", "광진구",
        "동대문구", "중랑구", "성북구",
        "강북구", "도봉구", "노원구",
        "은평구", "서대문구", "마포구",
        "양천구", "강서구", "구로구",
        "금천구", "영등포구", "동작구",
        "관악구", "서초구", "송파구",
        "강동구"
    ] //  나중에 지역 api 받아오기

    var body: some View {
        VStack {
            GroupNavigation(title: "새 그룹 만들기") {
                print("뒤로가기 버튼 클릭")
            }

            ScrollView {
                VStack(alignment: .leading) {
                    stepIndicatorView()
                        .padding(.top, 35)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("방문하실 지역을 선택해주세요")
                            .font(.Subtitle1)
                            .padding(.top, 49)
                        Text("하위 지역을 선택해주세요")
                            .font(.body2)
                            .padding(.top, 20)
                    }

                    locationGridView()
                        .padding(.top, 20)

                    NextButton(title: "다음") {
                        print("다음 버튼 클릭")
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 35)
                            .fill((viewModel.selectedSubLocation ?? "").isEmpty ? Color.g2 : Color.m4)
                    )
                    .foregroundStyle((viewModel.selectedSubLocation ?? "").isEmpty ? .g4 : .white)
                    .padding(.top, 38)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 110)
            }
        }
    }

    // MARK: - 지역 선택 그리드
    private func locationGridView() -> some View {
        LazyVStack(alignment: .leading, spacing: 16) {
            ForEach(sublocations.chunked(into: 3), id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(row, id: \.self) { location in
                        LocationButton(
                            title: location,
                            isSelected: .constant(location == viewModel.selectedSubLocation),
                            action: {
                                viewModel.selectedSubLocation = location
                            }
                        )
                        .frame(width: 118, height: 55)
                    }
                }
            }
        }
    }

    // MARK: - 상단 1 .. 2 뷰 + 선택한 지역 표시
    private func stepIndicatorView() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 10) {
                ZStack {
                    Circle()
                        .fill(Color("g3")) // 비활성 상태 색상
                        .frame(width: 26, height: 26)
                    Text("1")
                        .font(.Subtitle2)
                        .foregroundStyle(.white)
                }

                HStack(spacing: 4) {
                    ForEach(0..<3) { _ in
                        Circle()
                            .fill(Color("m5"))
                            .frame(width: 3, height: 3)
                    }
                }

                ZStack {
                    Circle()
                        .fill(Color("m5"))
                        .frame(width: 26, height: 26)
                    Text("2")
                        .font(.Subtitle2)
                        .foregroundStyle(.white)
                }
            }
            HStack{
                //  1번 아래에 선택한 상위 지역 표시
                Text(selectedLocation)
                    .font(.caption)
                    .foregroundStyle(.g3)

                //  2번 아래에 선택한 하위 지역 표시
                Text(viewModel.selectedSubLocation ?? " ")
                    .font(.caption)
                    .foregroundStyle(.m5)
                    .opacity(viewModel.selectedSubLocation == nil ? 0 : 1) // 선택되지 않으면 숨김
                    .padding(.leading , 23)
            }
           
        }
    }
}

// MARK: - Preview
struct SubLocationSelectView_Preview: PreviewProvider {
    static var previews: some View {
        let container = DIContainer()
        return SubLocationSelectView(container: container, selectedLocation: "서울시")
            .previewLayout(.sizeThatFits)
    }
}
