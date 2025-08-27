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
        .padding(.bottom, 110)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
        .background(Color.bg1) // 배경 색상
        .sheet(isPresented: $isBottomSheetPresented) {
            GroupPluseBottomSheet()
                .presentationCornerRadius(21)
                .presentationDragIndicator(.hidden)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            let currentYear = Calendar.current.component(.year, from: Date())
            let currentMonth = Calendar.current.component(.month, from: Date())
            viewModel.fetchGroupSchedules(year: currentYear, month: currentMonth)
        }

    }
}

// Safe Area Insets 계산
var safeAreaInsets: UIEdgeInsets {
    (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
        .windows.first?.safeAreaInsets ?? .zero
}

// MARK: - Preview
struct GroupTabView_Previews: PreviewProvider {
    static var previews: some View {
        let container = DIContainer()

        return Group {

            GroupTabView(container: container)
                .previewDisplayName("iPhone SE")
                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
                .environmentObject(DIContainer())

          
        }
    }
}
