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
    
    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0, content: {
            CustomLogoNavi(onlyLogo: false)
            
            firstSection
                .padding(.top, 35)
            
            Spacer()
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
    
    private var firstSection: some View {
        VStack(alignment: .leading, spacing: 20, content: {
            topTitle
            
            firstScrollView
        })
        .padding(.horizontal, 16)
    }
    
    private var firstScrollView: some View {
        GeometryReader { geometry in
            ScrollViewReader { proxy in
                ScrollView(.horizontal, content: {
                    HStack(alignment: .top, spacing: 0, content: {
                        if let results = viewModel.courseInfoResponse {
                            ForEach(results, id: \.id) { data in
                                courseCardView(geometry: geometry, data: data)
                            }
                        }
                    })
                    .padding(.trailing, (geometry.size.width - 320) / 2)
                })
            }
            .scrollIndicators(.hidden)
            .task {
                print("hello")
            }
        }
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
}

struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        HomeView(container: DIContainer())
            .environmentObject(DIContainer())
    }
}
