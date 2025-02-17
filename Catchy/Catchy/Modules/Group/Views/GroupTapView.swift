//
//  GroupTabView.swift
//  Catchy
//
//  Created by 임소은 on 2/10/25.
//

import SwiftUI

struct GroupTabView: View {
    private let container: DIContainer

    @State private var isBottomSheetPresented: Bool = false // 바텀시트 상태 변수

    // MARK: - 초기화
    init(container: DIContainer) {
        self.container = container
    }

    // MARK: - body
    var body: some View {
        VStack(spacing: 0) {
            // 상단 네비게이션
            GroupLogoNavigation(
                onHomeButtonTap: {
                    print("홈 버튼 클릭")
                },
                onPlusButtonTap: {
                    isBottomSheetPresented.toggle() // 버튼 클릭 시 바텀시트 표시
                }
            )

            ScrollView {
                VStack {
                    //  CreateCalenderView에 container 전달
                    CalenderView(container: container)
                        .padding(.top, 10)

                    Spacer() // 하단 여백 추가
                }
                .padding(.top, 16)
            }
        }
        .background(Color.bg1) // 배경 색상
        .padding(.bottom, 110)
        .sheet(isPresented: $isBottomSheetPresented) { // 바텀시트 표시
            GroupPluseBottomSheet()
        }
    }
}

// MARK: - Preview
struct GroupTabView_Previews: PreviewProvider {
    static var previews: some View {
        let container = DIContainer()
        return ForEach(["iPhone 16 Pro Max", "iPhone SE"], id: \.self) { deviceName in
            GroupTabView(container: container)
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
