//
//  CourseView.swift
//  Catchy
//
//  Created by LEE on 1/20/25.
//

import SwiftUI
import FloatingButton

struct CourseView: View {
    
    @EnvironmentObject var container: DIContainer
    
    /// 코스 뷰 모델
    @StateObject var viewModel: CourseViewModel
        
    /// 드랍 다운 메뉴의 뷰 모델
    @StateObject var provinceViewModel: GetProvinceViewModel = .init()
    
    /// AI 코스 생성로딩 화면 상태
    @Binding var isAILoadingPresented: Bool
    
    /// AI 코스 생성결과 화면 상태
    @Binding var isAISheetPresented: Bool
    
    init(container: DIContainer, isAILoadingPresented: Binding<Bool>, isAISheetPresented: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
        self._isAISheetPresented = isAISheetPresented
        self._isAILoadingPresented = isAILoadingPresented
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            
            DropDown(viewModel: viewModel, provinceViewModel: provinceViewModel).zIndex(1)
                .padding(.top, 50)
            
            VStack {
                navigationGroup
                
                if !viewModel.isCourseListLoading {
                    
                    if viewModel.courseList.isEmpty {
                        infoView
                    } else {
                        scrollView
                    }
                    
                } else {
                    
                    Spacer()
                    
                    ProgressView()
                    
                    Spacer()
                }
                
            }
            .zIndex(0)
        }.task{
            viewModel.getCourseList()
        }
        .onChange(of: provinceViewModel.provinces){ (_ , provinces) in
            viewModel.upperLocations = provinces
        }
        .onChange(of: viewModel.selectedUpperIndex) { (_, _) in
            viewModel.resetAndFetchCourseList()
        }
        .onChange(of: viewModel.selectedLowerIndex) { (_, lowerIndex) in
            if lowerIndex != nil {
                viewModel.resetAndFetchCourseList()
            }
        }
        .onChange(of: viewModel.segment) { (_, _) in
            viewModel.resetAndFetchCourseList()
        }
        .onChange(of: viewModel.isAICourseLoadingFinish) { (_, finished) in
            if finished {
                isAILoadingPresented.toggle()
                isAISheetPresented.toggle()
                viewModel.isAICourseLoadingFinish.toggle()
            }
        }
        .fullScreenCover(isPresented: $isAILoadingPresented) {
            AILoadingView(viewModel: viewModel)
        }
        .sheet(isPresented: $isAISheetPresented) {
            AIPlaceListView(courseAIResponse: viewModel.courseAIResponse, container: container, isAISheetPresented: $isAISheetPresented)
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
    }
    
    /// 스크롤 뷰 
    private var scrollView : some View {
        ScrollView(.vertical, content: {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 1), spacing: 18, content: {
                
                ForEach(viewModel.courseList, id: \.id) { course in
                        CourseGroupCard(course: course)
                        .onTapGesture {
                            container.navigationRouter.push(to: .courseDetailView(courseId: course.courseId))
                        }
                        .task {
                            guard let lastId = viewModel.lastId else { return }
                            if course.courseId >= lastId {
                                viewModel.getCourseList()
                            }
                        }
                    }
                
            })
            
            .padding(.horizontal, 16)
            .padding(.top, 10)
        })
        .padding(.top, 50)
        .padding(.bottom, 110)
        .frame(maxWidth: .infinity)
        .scrollIndicators(.hidden)
        .refreshable {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                viewModel.isLast = false
                viewModel.courseList = []
                viewModel.getCourseList()
            })
        }
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


