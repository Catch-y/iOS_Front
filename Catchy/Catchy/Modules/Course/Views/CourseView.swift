//
//  CourseView.swift
//  Catchy
//
//  Created by LEE on 1/20/25.
//

import SwiftUI
import FloatingButton

struct CourseView: View {
    
    @StateObject var viewModel: CourseViewModel
    
    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
    }
    
    var body: some View {
        
        ZStack(alignment: .top) {
            if let data = viewModel.courseResponse, !data.content.isEmpty {
                DropDown(viewModel: viewModel).zIndex(1)
            }
            VStack {
                if !viewModel.isCourseListLoading {
                    
                    navigationGroup
                    if let data = viewModel.courseResponse {
                        if data.content.isEmpty {
                            infoView
                        } else {
                            scrollView
                        }
                    }
                    
                } else {    /// 데이터 로딩 중
                    Spacer()
                        
                    ProgressView()
                        
                    Spacer()
                }
                    
            }
            .zIndex(0)
            
            if viewModel.isFloating {
                Color.black
                    .opacity(0.8)
                    .ignoresSafeArea(.all)
                    .zIndex(2)
            }
            AddFloatingButton(isOpen: $viewModel.isFloating).zIndex(3)
            
        }.task{
            viewModel
                .getCourseList(
                    courseRequest: .init(
                        type: .ai,
                        upperLocation: "",
                        lowerLocation: "",
                        lastId: 0
                    )
                )
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
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 1), spacing: 18, content: {
                if let content = viewModel.courseResponse?.content {
                    ForEach(content, id: \.id) { course in
                        CourseGroupCard(course: course)
                            
                    }
                }
            })
            
            .padding(.horizontal, 16)
            .padding(.top, 10)
        })
        .padding(.top, 70)
        .padding(.bottom, 110)
        .frame(maxWidth: .infinity)
        .scrollIndicators(.hidden)
        .border(.red)
    }
    
    /// 코스가 없을 때 텍스트 뷰
    private var infoView : some View {
        VStack(spacing: 9){
            Text("생성된 코스가 없습니다.")
                .font(.Subtitle2)
                .foregroundStyle(.g7)
            Text("코스를 새로 만들어보세요!")
                .font(.body1)
                .foregroundStyle(.g4)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(edges: .all)
        .padding(.bottom, 110)
    }
}

struct CourseView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 16 Pro", "iPhone 11"], id: \.self) { deviceName in
            CourseView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}

