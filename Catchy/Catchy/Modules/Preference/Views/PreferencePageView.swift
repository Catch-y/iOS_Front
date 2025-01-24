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
//            pageTwoContent(0)
        default:
            Text("112")
        }
    }
    
    // MARK: - Page 1
    
    private var pageOne: some View {
        VStack(alignment: .leading, spacing: 69, content: {
            Text("반가워요 \(DataFormatter.shared.makeStyledText(for: UserState.shared.getUserNickname())) 님!\n관심 있는 카테고리를 선택해주세요")
                .font(.Subtitle1)
                .foregroundStyle(Color.g7)
                .lineSpacing(3.3)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 0, maximum: 190), spacing: 30), count: 2), spacing: 28, content: {
                ForEach(CategoryType.allCases, id: \.self) { category in
                    MainCategoryBtn(categoryType: category) { selectedCategory in
                        viewModel.bigCategoryBtn.append(selectedCategory)
                    }
                }
            })
        })
    }
    
    // MARK: - Page 2
    
    private var pageTwo: some View {
        Text("11")
    }
    
    /// 두 번째 설문조사 상단 타이틀
    /// - Parameter index: 저장된 대 카테고리의 몇 번쨰에 해당하는 가?
    /// - Returns: 뷰 타입
    private func pageTwoTitle(_ index: Int) -> some View {
        VStack(alignment: .leading, spacing: 10, content: {
            viewModel.bigCategoryBtn[index].reeturnIcon()
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
            
            Text(viewModel.bigCategoryBtn[index].rawValue)
                .font(.Headline1)
                .foregroundStyle(Color.white)
            
            
            Text(viewModel.bigCategoryBtn[index].retrunCategoryDescrip().customLineBreak())
                .font(.body2)
                .foregroundStyle(Color.g3)
                .padding(.top, 9)
        })
        .frame(width: 293)
    }
    
    private func pageTwoContent(_ index: Int) -> some View {
        VStack(alignment: .leading, spacing: 39, content: {
            Group {
                Text("선호하는 ")
                    .font(.Subtitle3)
                + Text("주류 장소")
                    .font(.naviFont)
                + Text("를 한 개 이상 선택하세요!")
                    .font(.Subtitle3)
            }
            .foregroundStyle(Color.categoryDes)
        })
    }
}
struct PerferencePageView_Preview: PreviewProvider {
    static var previews: some View {
        PreferencePageView(viewModel: PreferenceViewModel())
    }
}
