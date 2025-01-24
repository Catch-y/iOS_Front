//
//  PreferenceView.swift
//  Catchy
//
//  Created by 정의찬 on 1/23/25.
//

import SwiftUI

struct PreferencePageView: View {
    
    @ObservedObject var viewModel: PreferenceViewModel
    
    var body: some View {
        switch viewModel.preferenceStep {
        case 0:
            pageOne
        default:
            Text("112")
        }
    }
    
    // MARk: - Page 1
    private var pageOne: some View {
        VStack(alignment: .leading, spacing: 69, content: {
            Text("반가워요 \(DataFormatter.shared.makeStyledText(for: UserState.shared.getUserNickname())) 님!\n관심 있는 카테고리를 선택해주세요")
                .font(.Subtitle1)
                .foregroundStyle(Color.g7)
                .lineSpacing(3.3)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 0, maximum: 190), spacing: 30), count: 2), spacing: 28, content: {
                ForEach(CategoryType.allCases, id: \.self) { category in
                    MainCategoryBtn(categoryType: category) { selectedCategory in
                        viewModel.selectedBtn.append(selectedCategory)
                    }
                }
            })
        })
    }
    
    private var pageTwo: some View {
        Text("11")
    }
}

struct PerferencePageView_Preview: PreviewProvider {
    static var previews: some View {
        PreferencePageView(viewModel: PreferenceViewModel())
    }
}
