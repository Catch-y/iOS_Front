//
//  CourePollAlert.swift
//  Catchy
//
//  Created by Apple Coding machine on 10/20/25.
//

import SwiftUI

/// 코스에 추가 카테고리 투표
struct CourePollAlert: View {
    // MARK: - Property
    @Environment(\.dismiss) var dismiss
    @State private var selectedCategories: Set<CategoryType> = []
    let strategy: PollStrategy
    let checkAction: ([CategoryType]) -> Void
    
    // MARK: - Constants
    fileprivate enum CoursePollAlertConstant {
        static let mainVspacing: CGFloat = 30
        static let middleVspacing: CGFloat = 20
        static let topVspacing: CGFloat = 8
        static let cateogryHspacing: CGFloat = 8
        
        static let middlePadding: CGFloat = 8
        static let horizonPadding: CGFloat = 8
        static let scrollBottomPadding: CGFloat = 10
        
        static let minLength: CGFloat = 80
        static let lineSpacing: CGFloat = 2.5
        
        static let iconSize: CGSize = .init(width: 35, height: 35)
        static let checkSize: CGSize = .init(width: 20, height: 20)
        static let imageSize: CGSize = .init(width: 14, height: 14)
        
        static let generateTitle: String = "코스에 추가"
    }
    
    // MARK: - Init
    init(strategy: PollStrategy, checkAction: @escaping ([CategoryType]) -> Void) {
        self.strategy = strategy
        self.checkAction = checkAction
    }
    
    // MARK: - Body
    var body: some View {
        ScrollView(.vertical, content: {
            VStack(spacing: CoursePollAlertConstant.mainVspacing, content: {
                closeBtn
                topContents
                Divider()
                    .foregroundStyle(.g2)
                middleContents
                Spacer(minLength: CoursePollAlertConstant.minLength)
            })
            .safeAreaBar(edge: .bottom, content: {
                bottomContents
            })
        })
        .contentMargins(.bottom, CoursePollAlertConstant.scrollBottomPadding, for: .scrollContent)
    }
    
    // MARK: - Top
    /// 상단영역
    private var topContents: some View {
        VStack(spacing: CoursePollAlertConstant.topVspacing, content: {
            ForEach(strategy.sections, id: \.id) { section in
                Text(title(section.title))
                    .font(.Subtitle3)
                    .foregroundStyle(.g7)
                    .multilineTextAlignment(.center)
                    .lineSpacing(CoursePollAlertConstant.lineSpacing)
                
                Text(section.description)
                    .font(.body3)
                    .foregroundStyle(.g4)
            }
        })
        .padding(.horizontal, CoursePollAlertConstant.horizonPadding)
    }
    
    private var closeBtn: some View {
        HStack {
            Spacer()
            CloseBtn(action: {
                dismiss()
            })
        }
        .padding(.horizontal, CoursePollAlertConstant.horizonPadding)
    }
    
    private func title(_ title: String) -> AttributedString {
        var str = AttributedString(title)
        if let range = str.range(of: CoursePollAlertConstant.generateTitle) {
            str[range].foregroundColor = .main
            str[range].font = .Subtitle3
        }
        
        return str
    }
    
    // MARK: - Middle
    private var middleContents: some View {
        VStack(spacing: CoursePollAlertConstant.middleVspacing, content: {
            ForEach(strategy.categoryType.enumerated(), id: \.offset) { idx, type in
                categoryRowView(type)
                
                if idx != strategy.categoryType.count - 1 {
                    Divider()
                        .foregroundStyle(.g2)
                }
            }
        })
        .padding(.horizontal, CoursePollAlertConstant.horizonPadding)
    }
    
    /// 카테고리 한 줄 아이콘
    /// - Parameter type: 카테고리 타입
    /// - Returns: 카테고리 줄 표현
    private func categoryRowView(_ type: CategoryType) -> some View {
        HStack {
            categoryIcon(type)
            Spacer()
            
            Button(action: {
                categoryCheckAction(type)
            }, label: {
                Image(selectedCategories.contains(type) ? .checkBtnSelected : .checkBtnUnselected)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: CoursePollAlertConstant.checkSize.width, height: CoursePollAlertConstant.checkSize.height)
            })
        }
    }
    
    /// 카테고리 체크 액션
    /// - Parameter category: 카테고리 타입
    private func categoryCheckAction(_ category: CategoryType) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
    }
    
    private func categoryIcon(_ type: CategoryType) -> some View {
        HStack(spacing: CoursePollAlertConstant.cateogryHspacing, content: {
            Image(type.voteImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: CoursePollAlertConstant.iconSize.width, height: CoursePollAlertConstant.iconSize.height)
            
            Text(type.rawValue)
                .font(.Body1_2)
                .foregroundStyle(.g6)
        })
    }
    
    // MARK: - Bottom
    /// 하단 버튼 영역
    private var bottomContents: some View {
        MainButton(btnType: .check(onOff: btnActivie ? .off : .on), action: {
            checkAction(Array(selectedCategories))
        })
        .padding(.horizontal, CoursePollAlertConstant.horizonPadding)
        .disabled(btnActivie)
    }
    
    private var btnActivie: Bool {
        return selectedCategories.isEmpty
    }
}

#Preview {
    CourePollAlert(strategy: PollStrategy(buttonType: .check(onOff: .off)), checkAction: { category in
        print(category)
    })
}
