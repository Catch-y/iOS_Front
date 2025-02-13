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
    
    /// 플로팅 버튼이 눌린 상태
    @Binding var isFloating: Bool
    
    /// AI 생성 플로팅 버튼이 눌린 상태
    @Binding var isAIPresented: Bool
    
    /// DIY 생성 플로팅 버튼이 눌린 상태
    @Binding var isDIYPresented: Bool
    
    /// 드랍 다운 메뉴의 뷰 모델
    @StateObject var provinceViewModel: GetProvinceViewModel = .init()

    init(container: DIContainer, isFloating: Binding<Bool>, isAIPresented: Binding<Bool>, isDIYPresented: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
        self._isFloating = isFloating
        self._isAIPresented = isAIPresented
        self._isDIYPresented = isDIYPresented
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
            .fullScreenCover(isPresented: $isAIPresented) {

                AILoadingView(container: viewModel.container)
            }
            .onChange(of: viewModel.selectedUpperIndex) { (_, _) in
                viewModel.isCourseListLoading = true
                viewModel.lastId = nil
                viewModel.courseList.removeAll()
                viewModel.isLast = false
                viewModel.getCourseList()
            }
            .onChange(of: viewModel.selectedLowerIndex) { (_, lowerIndex) in
                if lowerIndex != nil {
                    viewModel.isCourseListLoading = true
                    viewModel.lastId = nil
                    viewModel.courseList.removeAll()
                    viewModel.isLast = false
                    viewModel.getCourseList()
                }
            }
            .onChange(of: viewModel.segment) { (_, _) in
                viewModel.isCourseListLoading = true
                viewModel.lastId = nil
                viewModel.courseList.removeAll()
                viewModel.isLast = false
                viewModel.getCourseList()
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


