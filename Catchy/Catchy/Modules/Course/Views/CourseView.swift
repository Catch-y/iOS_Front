//
//  CourseView.swift
//  Catchy
//
//  Created by LEE on 1/20/25.
//

import SwiftUI
import FloatingButton

struct CourseView: View {
    
    @StateObject var viewModel: CourseViewModel = dummnyCourseViewModel.dummy()
    
    //@State private var isDropdownOpen = false
    //@State private var isFloatingButtonOpen = false
    
    var body: some View {
        ZStack {
            VStack {
                navigationGroup
                Spacer()
                scrollView
            }
                   
            /// 화면 어둡게
            /// 플로팅 버튼이 열려 있을 때,
            if viewModel.isOpen {
                Color.black
                    .opacity(0.8)
                    .ignoresSafeArea(.all)
                    .zIndex(1)
            }
                   
            /// 플로팅 버튼
            AddFloatingButton(isOpen: $viewModel.isOpen)
                .zIndex(2)
            }
    }


    
    /// 네비게이션 바와 세그먼트 그룹
    private var navigationGroup : some View {
        VStack(alignment: .center) {
            CustomLogoNavi(onlyLogo : true)
            CustomSegment<CourseSegment>(selectedSegment: $viewModel.segment)
                .frame(height: 66)
                
        }
        .ignoresSafeArea(.all)
    }
    
    /// 스크롤 뷰 
    private var scrollView : some View {
        ScrollView(.vertical, content: {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 0, maximum: 400)), count: 1), spacing: 18, content: {
                ForEach(viewModel.courseList, id: \.id) { course in
                    CourseGroupCard(course: course)
                }
            })
            .padding(.horizontal, 16)
            .padding(.top, 11)
        })
        .padding(.bottom, 110)
        .frame(maxWidth: .infinity)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    CourseView()
}
