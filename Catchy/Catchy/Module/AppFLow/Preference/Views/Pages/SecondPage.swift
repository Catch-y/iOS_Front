//
//  SecondPage.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/19/25.
//

import SwiftUI

struct SecondPage: View {
    // MARK: - Property
    @Bindable var viewModel: PreferenceViewModel
    
    // MARK: - Constants
    fileprivate enum SecondPageConstants {
        static let middleVspacing: CGFloat = 19
        static let middleTitleVspacing: CGFloat = 10
        static let bottomSubVspacing: CGFloat = 39
        static let columnsSpacing: CGFloat = 56
        static let columnRowSpacing: CGFloat = 32
        static let minSpacer: CGFloat = 60
        static let maxSpacer: CGFloat = 40
        
        static let leadingPadding: CGFloat = 28
        
        static let middleIconSize: CGSize = .init(width: 30, height: 30)
        static let middleScrollSize: CGFloat = 200
        
        static let middleLinelimit: Int = 2
        static let columnsCount: Int = 2
        static let blur: CGFloat = 7.5
        
        static let bottomSubCategoryDescrip: [String] = ["선호하는", "장소", "를 한개 이상 선택하세요!"]
        static let nextBtn: String = "chevron.right"
    }
    
    // MARK: - Init
    init(viewModel: PreferenceViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Body
    var body: some View {
        GeometryReader(content: { _ in
            VStack(alignment: .leading, spacing: .zero, content: {
                topContents
                Spacer().frame(maxHeight: SecondPageConstants.maxSpacer)
                middleContents
            })
            .background {
                bodyBgImage
            }
        })
        .safeAreaInset(edge: .top, spacing: DefaultConstants.defaultCapsuleSpacing, content: {
            navigationBtn
        })
        .transition(.move(edge: .leading).combined(with: .opacity))
        .loadingOverlay(isLoading: viewModel.isLoading, loadingTextType: .mapLoading)
    }
    
    /// 배경 백그라운드
    private var bodyBgImage: some View {
        ZStack {
            Image(viewModel.bigCategoryBtn[viewModel.categoryPage].categoryBgImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .blur(radius: SecondPageConstants.blur)
                .ignoresSafeArea()
            
            LinearGradient(
                stops: [
                    Gradient.Stop(color: .black.opacity(0.8), location: 0.00),
                    Gradient.Stop(color: Color(red: 0.09, green: 0.09, blue: 0.09).opacity(0.16), location: 1.00),
                ],
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 1)
            )
            .backgroundExtensionEffect()
            .animation(.easeInOut(duration: DefaultConstants.animationTime), value: viewModel.categoryPage)
        }
    }
    
    private var navigationBtn: some View {
        NavigationBar(action: {
            viewModel.preferencPage = .one(nickname: viewModel.nickname)
        }, color: .white) {
            if viewModel.categoryPage == viewModel.bigCategoryBtn.count - 1 {
                nexButton
            }
        }
        .padding(.horizontal, DefaultConstants.defaultSafeHorizon)
    }
    
    // MARK: - Top
    /// 상단 페이지 컨트롤
    private var topContents: some View {
        PageControl(pageCount: $viewModel.categoryPage, totalPageCount: viewModel.bigCategoryBtn.count)
            .padding(.leading, SecondPageConstants.leadingPadding)
    }
    
    // MARK: - Middle
    private var middleContents: some  View {
        TabView(selection: $viewModel.categoryPage, content: {
            ForEach(Array(viewModel.bigCategoryBtn.enumerated()), id: \.offset) { index, category in
                VStack(alignment: .leading, spacing: .zero, content: {
                    middleTopGroup(category)
                    Spacer().frame(maxHeight: SecondPageConstants.minSpacer)
                    bottomSubCategory(category)
                })
            }
        })
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .task {
            viewModel.categoryPage = 0
        }
    }
    
    /// 중간 컨텐츠
    /// - Parameter category: 컨텐츠 카테고리
    /// - Returns: 카테고리 설명 뷰 반환
    private func middleTopGroup(_ category: CategoryType) -> some View {
        VStack(alignment: .leading, spacing: SecondPageConstants.middleVspacing, content: {
            middleTitle(category)
            middleSubTitle(category)
        })
        .padding(.horizontal, SecondPageConstants.leadingPadding)
    }
    
    /// 중간 카데고리 타이틀
    /// - Parameter category: 카테고리 값
    /// - Returns: 카테고리 타이틀 뷰 반환
    private func middleTitle(_ category: CategoryType) -> some View {
        VStack(alignment: .leading, spacing: SecondPageConstants.middleTitleVspacing, content: {
            Image(category.categoryImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: SecondPageConstants.middleIconSize.width, height: SecondPageConstants.middleIconSize.height)
            
            Text(category.rawValue)
                .font(.Headline1)
                .foregroundStyle(Color.white)
        })
    }
    
    /// 중간 카테고리 서브 내용
    /// - Parameter category: 카테고리 설명
    /// - Returns: 뷰 반환
    private func middleSubTitle(_ category: CategoryType) -> some View {
        Text(category.categoryDescription)
            .font(.body2)
            .foregroundStyle(Color.g3)
            .lineLimit(SecondPageConstants.middleLinelimit)
            .lineSpacing(DefaultConstants.lineSpacing)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // MARK: - Bottom
    /// 하단 버튼 영역
    /// - Parameter category: 버튼 영역에 해당하는 카테고리
    /// - Returns: 소 카테고리 뷰
    private func bottomSubCategory(_ category: CategoryType) -> some View {
        VStack(alignment: .leading, spacing: SecondPageConstants.bottomSubVspacing, content: {
            bottomSubCategoryDescrip(category)
            bottomSubCategories(category)
        })
    }
    
    /// 서브 카테고리 선택 설명
    /// - Parameter category: 카테고리
    /// - Returns: 서브 카테고리 설명 뷰 반환
    private func bottomSubCategoryDescrip(_ category: CategoryType) -> some View {
        HStack(spacing: .zero, content: {
            Text(SecondPageConstants.bottomSubCategoryDescrip[0])
                .font(.Subtitle3)
            Text(" \(category.rawValue) \(SecondPageConstants.bottomSubCategoryDescrip[1])")
                .font(.naviFont)
            Text(SecondPageConstants.bottomSubCategoryDescrip[2])
                .font(.Subtitle3)
        })
        .foregroundStyle(Color.categoryDes)
        .padding(.leading, SecondPageConstants.leadingPadding)
    }
    
    /// 서브 카테고리 값
    /// - Parameter category: 카테고리
    /// - Returns: 카테고리 뷰 반환
    @ViewBuilder
    private func bottomSubCategories(_ category: CategoryType) -> some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: SecondPageConstants.columnsSpacing), count: SecondPageConstants.columnsCount)
        
        ScrollView(.vertical, content: {
            LazyVGrid(columns: columns, spacing: SecondPageConstants.columnRowSpacing, content: {
                ForEach(category.subcategories, id: \.self) { sub in
                    SubCategoryBtn(
                        isSelected: subCategoryBtnBinding(category, sub),
                        subCategory: sub)
                }
            })
        })
        .contentMargins(.horizontal, DefaultConstants.defaultSafeHorizon, for: .scrollContent)
    }
    
    /// 서브 카테고리 버튼 바인딩 액션
    /// - Parameters:
    ///   - category: 카테고리 값
    ///   - sub: 서브 카테고리 버튼 이름
    /// - Returns: 바인딩 Bool 반환
    private func subCategoryBtnBinding(_ category: CategoryType, _ sub: String) -> Binding<Bool> {
        .init(
            get: { viewModel.smallCategoryBtn[category]?.contains(sub) ?? false },
            set: { isSelected in
                if isSelected {
                    if viewModel.smallCategoryBtn[category] == nil {
                        viewModel.smallCategoryBtn[category] = []
                    }
                    viewModel.smallCategoryBtn[category]?.append(sub)
                } else {
                    viewModel.smallCategoryBtn[category]?.removeAll { $0 == sub}
                }
        })
    }
    
    /// 하단 마지막 페이지 버튼
    private var nexButton: some View {
        NextButton(action: {
            viewModel.preferencPage = .three
        }, value: btnCheck)
        .glassEffect(.regular, in: .circle)
        .disabled(btnCheck)
        .padding(.horizontal, DefaultConstants.defaultSafeHorizon)
    }
    
    private var btnCheck: Bool {
        (viewModel.smallCategoryBtn[viewModel.bigCategoryBtn.last!] ?? []).isEmpty
    }
}

#Preview {
    SecondPage(viewModel: .init(container: DIContainer(), appFlow: AppFlow()))
}
