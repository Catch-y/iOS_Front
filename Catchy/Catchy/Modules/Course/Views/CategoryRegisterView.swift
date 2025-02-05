//
//  CategoryRegisterView.swift
//  Catchy
//
//  Created by LEE on 2/4/25.
//

import SwiftUI

struct CategoryRegisterView: View {
    
    /// 현재 선택된 카테고리
    @State var selectedCategory: [CategoryType: String] = [:]
    
    /// 카태고리 선택 시 스크롤 뷰 하단으로 이동
    @Namespace var bottomID
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            CustomNavigation(
                action: {
                    // TODO: - 화면 닫기
                    print("화면 닫기")
                },
                title: "카테고리 선택",
                leftNaviIcon: nil,
                isShadow: true
            )
                        
            infoText
                        
            scrollView
            

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
                        // TODO: - 장소 카테고리 선택 API 요청
                    },
                    width: 400,
                    height: 60,
                    onoff: selectedCategory.isEmpty ? .off : .on
                )
                .id(bottomID)
                
            }
            .onChange(of: selectedCategory) { (_, _) in
                if !selectedCategory.isEmpty {
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

extension CategoryRegisterView {
    
    /// 서브 카테고리 선택 버튼
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
                                return selectedCategory[category] == subcategory
                            },
                            set: { newValue in
                                
                                if newValue {
                                    selectedCategory.removeAll()
                                    selectedCategory[category] = subcategory
                                    
                                } else {
                                    selectedCategory[category] = nil
                                }
                            }
                        ),
                        text: subcategory
                    )
                }
                
                
            }
        
        
        
    }
}


struct CategoryRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(
            ["iPhone 16 Pro Max", "iPhone 11", "iPhone 12 mini"],
            id: \.self
        ) { deviceName in
            CategoryRegisterView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}


