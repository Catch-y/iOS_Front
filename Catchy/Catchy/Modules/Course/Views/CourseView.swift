//
//  CourseView.swift
//  Catchy
//
//  Created by LEE on 1/20/25.
//

import SwiftUI
import FloatingButton

struct CourseView: View {
    
    @ObservedObject var viewModel: CourseViewModel = dummnyCourseViewModel.dummy()
    
    @State private var isDropdownOpen = false
    @State private var isFloatingButtonOpen = false
    @State var segment: CourseSegment = .diy
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack(alignment: .top){
        
                if isFloatingButtonOpen {
                    Color.black.opacity(0.8)
                        .edgesIgnoringSafeArea(.all)
                        .zIndex(2)
                }
                
                /// 네비게이션 바와 세그먼트
                VStack(alignment: .center) {
                    CustomLogoNavi(onlyLogo: true)
                    CustomSegment<CourseSegment>(selectedSegment: $segment)
                        .frame(height: 66)
                        
                }
                .ignoresSafeArea(.all)
                .zIndex(1)
                        
                /// 스크롤 뷰
                ScrollView {
                    VStack(alignment: .center, spacing: 18) {
                        ForEach(viewModel.courseList, id: \.id) { course in
                            CourseListCard(course: course)
                        }
                    }
                    .padding(.top, 10)
                    .padding(.horizontal, 16)
                }
                .scrollIndicators(.hidden)
                .padding(.bottom, 130)
                .padding(.top, 250)

                .zIndex(0)
                .refreshable {
                    // TODO: 리프레시 구현
                }
                .ignoresSafeArea(.all)
            
                
                FloatingButton(
                        mainButtonView: MainFloatingButton(isOpen: $isFloatingButtonOpen),
                        buttons: [
                            AnyView(AIFloatingButton(isOpen: $isFloatingButtonOpen)),
                            AnyView(DIYFloatingButton(isOpen: $isFloatingButtonOpen))
                        ],
                        isOpen: $isFloatingButtonOpen
                    )
                    .straight()
                    .direction(.top)
                    .alignment(.right)
                    .spacing(10)
                    .animation(.spring())
                    .delays(delayDelta: 0.2)
                    .zIndex(2)
                    .position(x: geometry.size.width - 16 - 35, y: geometry.size.height - 80)
                
            }
            .ignoresSafeArea(.all)
        }
        
        
        
    }
}

#Preview {
    CourseView()
}
