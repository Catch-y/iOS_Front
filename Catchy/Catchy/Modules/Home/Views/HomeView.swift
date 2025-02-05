//
//  HomeView.swift
//  Catchy
//
//  Created by 정의찬 on 1/14/25.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var container: DIContainer
    @StateObject var viewModel: HomeViewModel
    
    @State var isRotationEnabled: Bool = false
    
    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0, content: {
            CustomLogoNavi(onlyLogo: false)
            
            ScrollView(.vertical, content: {
                if let data = viewModel.courseInfoResponse {
                    firstSection(data: data)
                        .padding(.top, 35)
                        .border(Color.red)
                }
                
                if let data = viewModel.popularCourseResponse {
                    seconSection(datas: data)
                        .padding(.top, 42)
                }
                
                Spacer()
            })
            .frame(maxHeight: .infinity)
            .border(Color.red)
        })
        .ignoresSafeArea(.all)
    }
    
    private var topTitle: some View {
        Text(DataFormatter.shared.makeStyledText(for: "\(UserState.shared.getUserNickname())님의 취향을 저격할 \n코스를 알려드릴게요!"))
            .multilineTextAlignment(.leading)
            .font(.Subtitle2)
            .foregroundStyle(Color.g7)
            .lineSpacing(3)
    }
    
    private func firstSection(data: [CourseInfoResponse]) -> some View {
        VStack(alignment: .leading, spacing: 20, content: {
            topTitle
            
            firstScrollView(data: data)
        })
        .padding(.horizontal, 16)
    }
    
    private func firstScrollView(data: [CourseInfoResponse]) -> some View {
        GeometryReader { geometry in
            ScrollViewReader { proxy in
                ScrollView(.horizontal, content: {
                    HStack(alignment: .top, spacing: 0, content: {
                        ForEach(data, id: \.id) { data in
                            courseCardView(geometry: geometry, data: data)
                        }
                    })
                    .scrollTargetLayout()
                    .padding(.trailing, (geometry.size.width - 320) / 2)
                })
                .scrollTargetBehavior(.viewAligned)
            }
            .scrollIndicators(.hidden)
        }
        .frame(minHeight: 240)
    }
    
    private func seconSection(datas: [PopularCourseResponse]) -> some View {
        VStack(alignment: .leading, spacing: 20, content: {
            Text(DataFormatter.shared.makeStyledText(for: "이번주 인기코스 TOP 10"))
                .font(.Subtitle2)
                .foregroundStyle(Color.g7)
            GeometryReader { geo in
                ZStack(alignment: .topLeading, content: {
                    ScrollView(.horizontal, content: {
                        HStack(spacing: 15, content: {
                            ForEach(datas, id: \.id) { data in
                                PopularCourseCard(data: data)
                                    .visualEffect { content, geometryProxy in
                                        MainActor.assumeIsolated {
                                            content
                                                .scaleEffect(scale(geometryProxy, scale: 0.1), anchor: .trailing)
                                                .rotationEffect(rotaion(geometryProxy, rotation: 5))
                                                .offset(x: minX(geometryProxy))
                                                .offset(x: excessMinX(geometryProxy, offset: 10))
                                        }
                                    }
                                    .zIndex(datas.zIndex(data))
                            }
                        })
                        .padding(.vertical, 15)
                        .padding(.horizontal, 15)
                    })
                    .scrollTargetBehavior(.paging)
                    .frame(height: 280)
                })
            }
        })
        .padding(.horizontal, 16)
    }
    
}

extension HomeView {
    private func scaleValue(geometry: GeometryProxy, itemGeometry: GeometryProxy) -> CGFloat {
        let itemCenter = itemGeometry.frame(in: .global).midX
        let screenCenter = geometry.size.width / 2
        let distance = abs(screenCenter - itemCenter)
        let scale = 1 - (distance / (geometry.size.width * 0.8))
        return max(0.6, scale)
    }
    
    private func isCentered(geometry: GeometryProxy, itemGeometry: GeometryProxy) -> Bool {
        let itermCenter = itemGeometry.frame(in: .global).midX
        let screenCenter = geometry.size.width / 2
        return abs(itermCenter - screenCenter) < 50
    }
    
    private func courseCardView(geometry: GeometryProxy, data: CourseInfoResponse) -> some View {
        GeometryReader { item in
            HomeCourseCard(data: data)
                .scaleEffect(self.scaleValue(geometry: geometry, itemGeometry: item))
                .animation(.bouncy, value: scaleValue(geometry: geometry, itemGeometry: item))
        }
        .frame(minWidth: geometry.size.width - 32, maxHeight: 245)
    }
    
    private func progress(_ proxy: GeometryProxy, limit: CGFloat = 2) -> CGFloat {
        let maxX = proxy.frame(in: .scrollView(axis: .horizontal)).maxX
        let width = proxy.bounds(of: .scrollView(axis: .horizontal))?.width ?? 0
        let progress = (maxX / width) - 1.0
        let cappedProgress = min(progress, limit)
        
        return cappedProgress
    }
    
    private func scale(_ proxy: GeometryProxy, scale: CGFloat = 0.1) -> CGFloat {
        let progress = progress(proxy)
        
        return 1 - (progress * scale)
    }
    
    func excessMinX(_ proxy: GeometryProxy, offset: CGFloat = 10) -> CGFloat {
        let progress = progress(proxy)
        return progress * offset
    }
    
    func rotaion(_ proxy: GeometryProxy, rotation: CGFloat = 5) -> Angle {
        let progress = progress(proxy)
        return .init(degrees: progress * rotation)
    }
    
    func minX(_ proxy: GeometryProxy) -> CGFloat {
        let minX = proxy.frame(in: .scrollView(axis: .horizontal)).minX
        return minX < 0 ? 0 : -minX
    }
}

struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        HomeView(container: DIContainer())
            .environmentObject(DIContainer())
    }
}
