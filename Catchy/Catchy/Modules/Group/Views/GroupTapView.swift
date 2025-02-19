//
//  GroupTabView.swift
//  Catchy
//
//  Created by 임소은 on 2/10/25.
//

import SwiftUI

struct GroupTabView: View {
    @StateObject private var viewModel: GroupTabViewModel
    @EnvironmentObject var container: DIContainer

    @State private var isBottomSheetPresented: Bool = false // 바텀시트 상태 변수

    // MARK: - 초기화
    init(container: DIContainer) {
        _viewModel = StateObject(wrappedValue: .init(container: container))
       }

    // MARK: - body
    var body: some View {
        VStack(spacing: 0) {
            
            
            // 상단 네비게이션
            GroupLogoNavigation(
                onHomeButtonTap: {
                   //TODO: - 홈화면으로 이동해야하나..?
                },
                onPlusButtonTap: {
                    isBottomSheetPresented.toggle() // 버튼 클릭 시 바텀시트 표시
                }
            )

            ScrollView {
                VStack {
                    // CalenderView에 viewModel 전달
                    CalenderView(container: container)
                        .padding(.top, 10)

                    Spacer() // 하단 여백 추가
                }
                .padding(.top, 16)
            }
        }
        .background(Color.bg1) // 배경 색상
        .padding(.bottom, 110)
        .sheet(isPresented: $isBottomSheetPresented) {
            GroupPluseBottomSheet()
                .presentationCornerRadius(21)
                .presentationDragIndicator(.hidden)
        }
        .task {
            let currentYear = Calendar.current.component(.year, from: Date())
            let currentMonth = Calendar.current.component(.month, from: Date())
            viewModel.fetchGroupSchedules(year: currentYear, month: currentMonth)
        }

    }
}

// MARK: - Preview
struct GroupTabView_Previews: PreviewProvider {
    static var previews: some View {
        let container = DIContainer()

        return Group {
            GroupTabView(container: container)
                .previewDisplayName("iPhone 16 Pro")
                .previewDevice(PreviewDevice(rawValue: "iPhone 16 Pro"))

            GroupTabView(container: container)
                .previewDisplayName("iPhone SE")
                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))

          
        }
    }
}
