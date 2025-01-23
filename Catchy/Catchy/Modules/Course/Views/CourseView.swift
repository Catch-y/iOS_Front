//
//  CourseView.swift
//  Catchy
//
//  Created by LEE on 1/20/25.
//

import SwiftUI
import FloatingButton

struct CourseView: View {
    
    @StateObject var viewModel: CourseViewModel = dummyCourseViewModel.dummy()
    
    var body: some View {
        
        ZStack{
            VStack{
                navigationGroup
                scrollView
            }
            VStack{
                DropDown(viewModel: viewModel)
                Spacer()
            }
            if viewModel.isFloating {
                Color.black
                    .opacity(0.8)
                    .ignoresSafeArea(.all)
            }
            AddFloatingButton(isOpen: $viewModel.isFloating)
            
        }

        
    }


    /// 네비게이션 바와 세그먼트 그룹
    private var navigationGroup : some View {
        VStack(alignment: .center) {
            CustomLogoNavi(onlyLogo : true)
            CustomSegment<CourseSegment>(selectedSegment: $viewModel.segment)
                .frame(height: 66)
                .onChange(of: viewModel.segment, { (_, newValue) in
                    viewModel.segmentDidChange(to: newValue)
                })
        }
        .ignoresSafeArea(edges: .top)
        .frame(height: 130)
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
            .padding(.top, 10)
        })
        .padding(.top, 70)
        .padding(.bottom, 110)
        .frame(maxWidth: .infinity)
        .scrollIndicators(.hidden)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //        Group {
        //            CourseView()
        //                .previewDevice("iPhone 11")
        //            CourseView()
        //                .previewDevice("iPhone 16 Pro")
        //        }
        ForEach(["iPhone 16 Pro", "iPhone 11"], id: \.self) { deviceName in
            CourseView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}

