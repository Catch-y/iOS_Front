//
//  HomeView.swift
//  Catchy
//
//  Created by euijjang97 on 12/2/25.
//

import SwiftUI

struct HomeView: View {
    // MARK:  - Property
    @State var viewModel: HomeViewModel
    @AppStorage(AppStorageKey.userNickname) var nickname: String = "닉네임 없음"
    
    // MARK: - Constant
    fileprivate enum HomeConstants {
        static let lazyVspacing: CGFloat = 42
        static let containerSpacing: CGFloat = 40
        static let popularSectionSpacing: CGFloat = 16
        static let containerCount: Int = 1
    }
    
    // MARK: - Init
    init() {
        self._viewModel = State(wrappedValue: .init())
    }
    
    var body: some View {
        ScrollView(.vertical, content: {
            LazyVStack(alignment: .leading, spacing: HomeConstants.lazyVspacing, content: {
                ForEach(HomeSectionType.allCases, id: \.id) {
                    makeSection($0)
                }
            })
        })
        .safeAreaPadding(.horizontal, 16)
        .scrollEdgeEffectStyle(.soft, for: .all)
    }
    
    // MARK: - SectionBuilder
    /// 섹션 생성 함수
    /// - Parameter type: 섹션 타입
    /// - Returns: 섹션 뷰 반환
    @ViewBuilder
    private func makeSection(_ type: HomeSectionType) -> some View {
        let config = sectionConfig(type)
        HomeSectionFormView(baseTitle: config.baseTitle, rangeWord: config.rangeWord, content: {
            sectionContent(type)
        })
    }
    
    /// 섹션 헤더 반환
    /// - Parameter type: 섹션 헤더 생성
    /// - Returns: 섹션 헤더 반환
    private func sectionConfig(_ type: HomeSectionType) -> (baseTitle: String, rangeWord: [String]) {
        switch type {
        case .courseCardSection:
            return (
                baseTitle: "\(nickname)님의 취향을 저격할 \n코스를 알려드릴게요!",
                rangeWord: [nickname, "취향을 저격할"]
            )
        case .popularCourseCard:
            return (
                baseTitle: "이번주 인기코스 TOP 10",
                rangeWord: ["TOP 10"]
            )
        case .recommendPlaceCard:
            return (
                baseTitle: "\(nickname)님과 비슷한 취향을 가진 \n사람들이 좋아하는 장소!",
                rangeWord: [nickname, "비슷한 취향"]
            )
        }
    }
    
    /// 섹션 컨텐츠 생성 함수
    /// - Parameter type: 섹션 타입
    /// - Returns: 타입에 맞는 컨텐츠 반환
    @ViewBuilder
    private func sectionContent(_ type: HomeSectionType) -> some View {
        switch type {
        case .courseCardSection:
            courseCardSection
        case .popularCourseCard:
            Text("!")
        case .recommendPlaceCard:
            Text("!")
        }
    }
    
    // MARK: - SectionConents
    /// 첫 번째 섹션 컨텐츠
    private var courseCardSection: some View {
        ScrollView(.horizontal, content: {
            HStack(spacing: .zero, content: {
                ForEach(viewModel.courseData, id: \.id) {
                    CourseCard(data: $0)
                        .containerRelativeFrame(.horizontal, count: HomeConstants.containerCount, spacing: HomeConstants.containerSpacing)
                        .scrollTransition(.interactive, axis: .horizontal, transition: { content, phase in
                            content
                                .scaleEffect(phase.isIdentity ? 1.0 : 0.9)
                                .opacity(phase.isIdentity ? 1.0 : 0.5)
                        })
                }
            })
            .scrollTargetLayout()
        })
        .contentMargins(.bottom, DefaultConstants.defaultContentBottomMargins, for: .scrollContent)
        .contentMargins(.top, DefaultConstants.defaultContentTopMargins, for: .scrollContent)
        .scrollTargetBehavior(.viewAligned)
    }
    
//    /// 두 번째 섹션 컨텐츠
//    private var popularCardSection: some View {
//        ScrollView(.horizontal, content: {
//            HStack(spacing: HomeConstants.popularSectionSpacing, content: {
//                ForEach(viewModel.popularData, id: \.id) {
//                    PopularCourseCard(data: $0)
//                        .scrollTransition(axis: .horizontal, transition: { content, phase in
//                            content
//                                .rotation3DEffect(
//                                    .degrees(phase.value * -30),
//                                    axis: (x: 0, y: 1, z: 0),
//                                    perspective: 0.5
//                                )
//                                .scaleEffect(phase.isIdentity ? 1.0 : 0.8)
//                                .offset(y: phase.isIdentity ? 0 : 20)
//                                .brightness(phase.isIdentity ? 0 : -0.3)
//                        })
//                        .zIndex(phaseVa)
//                }
//            })
//        })
//    }
    
}
#Preview {
    HomeView()
}
