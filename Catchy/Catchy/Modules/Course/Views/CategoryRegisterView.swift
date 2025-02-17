//
//  CategoryRegisterView.swift
//  Catchy
//
//  Created by LEE on 2/4/25.
//

import SwiftUI

/// 장소 카테고리 선택 화면
struct CategoryRegisterView: View {
    
    // MARK: - 뷰 모델
    @StateObject var viewModel: PlaceCategoryRegisterViewModel
        
    // MARK: - 장소 카테고리 선택 화면 Properties
    /// 카태고리 선택 시 스크롤 뷰 하단으로 이동
    @Namespace var bottomID
    
    // MARK: - Init
    init(placeSearchResponseData: Binding<PlaceSearchResponseData>, container: DIContainer, isPresented: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: .init(container: container, placeSearchResponseData: placeSearchResponseData, isPresented: isPresented))
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            CustomNavigation(
                action: {
                    viewModel.close()
                },
                title: "카테고리 선택",
                leftNaviIcon: nil,
                isShadow: true
            )
                        
            infoText
                        
            scrollView
            
            Spacer()

        }
        .ignoresSafeArea(edges: .top)

        
    }
    
    /// 안내 문구
    private var infoText: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            Text("선택한 장소에 맞는 카테고리를 골라주세요!")
                .font(.Subtitle3_SM)
                .foregroundStyle(.g7)
            Text("카테고리는 1개만 선택 가능합니다.")
                .font(.body3)
                .foregroundStyle(.g4)
            
        }
        .padding(.horizontal, 16)
        .padding(.top, 10)
    }
    
    /// 스크롤 뷰
    /// 메인 버튼
    private var scrollView: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVGrid(
                    columns: Array(repeating: GridItem(.flexible()), count: 4),
                    alignment: .leading,
                    spacing: 10
                ) {
                    ForEach(
                        Array(CategoryType.allCases.enumerated()),
                        id: \.element
                    ) {
                        index,
                        category in
                        
                        makeSubSection(category: category)
                        
                    }
                }
                .padding(.bottom, 30)
                MainBtn(
                    text: "선택",
                    action: {
                        viewModel.postPlaceCategoryRegister()
                    },
                    width: UIScreen.screenWidth,
                    height: 60,
                    onoff: viewModel.selectedCategory.isEmpty ? .off : .on
                )
                .id(bottomID)
                
            }
            .onChange(of: viewModel.selectedCategory) { (_, _) in
                if !viewModel.selectedCategory.isEmpty {
                    withAnimation(.bouncy) {
                        proxy.scrollTo(bottomID, anchor: .bottom)
                    }
                }
            }
            .padding(.horizontal, 16)
            .scrollIndicators(.hidden)
            
        }
    }

       
}

// MARK: - Extension
extension CategoryRegisterView {
    
    /// 서브 카테고리 선택 버튼
    /// - Parameter category: 서브 카테고리 버튼을 생성할 메인 카테고리
    /// - Returns: 서브 카테고리 버튼
    func makeSubSection(category: CategoryType) -> some View {
        Section(header: Text(category.rawValue)
            .font(.body1)
            .foregroundStyle(.g6)
            .padding(.top, 10)
            .padding(.bottom, 10)) {
            
                ForEach(
                    category.subcategories,
                    id: \.self
                ) { subcategory in
                    CategoryButton(
                        category: category,
                        isSelected: Binding(
                            get: {
                                return viewModel.selectedCategory[category] == subcategory
                            },
                            set: { newValue in
                                
                                if newValue {
                                    viewModel.selectedCategory.removeAll()
                                    viewModel.selectedCategory[category] = subcategory
                                    
                                } else {
                                    viewModel.selectedCategory[category] = nil
                                }
                            }
                        ),
                        text: subcategory
                    )
                }
                
                
            }
        
        
        
    }
}
