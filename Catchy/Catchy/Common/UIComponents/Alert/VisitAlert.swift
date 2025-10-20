//
//  GuideAlert.swift
//  Catchy
//
//  Created by Apple Coding machine on 10/18/25.
//

import SwiftUI

/// 가이드 알림 Alert
struct VisitAlert: View {
    
    // MARK: - Property
    let strategy: GuideStrategy
    let dismissAction: () -> Void
    
    // MARK: - Constants
    fileprivate enum GuideAlertConstant {
        static let mainVspacing: CGFloat = 30
        static let sectionVspacing: CGFloat = 29
        static let sectionInnerVspacing: CGFloat = 21
        
        static let mainPadding: EdgeInsets = .init(top: 40, leading: 34, bottom: 24, trailing: 34)
        
        static let btnHeight: CGFloat = 52
        static let cornerRadius: CGFloat = 20
        static let checkText: String = "방문 체크하기"
    }
    
    // MARK: - Init
    init(strategy: GuideStrategy, dismissAction: @escaping () -> Void) {
        self.strategy = strategy
        self.dismissAction = dismissAction
    }
    
    // MARK: - Init
    var body: some View {
        VStack(spacing: GuideAlertConstant.mainVspacing, content: {
            sectionContents
            MainButton(btnType: strategy.buttonType, height: GuideAlertConstant.btnHeight, action: {
                dismissAction()
            })
        })
        .padding(GuideAlertConstant.mainPadding)
        .background {
            RoundedRectangle(cornerRadius: GuideAlertConstant.cornerRadius)
                .fill(.white)
                .frame(maxWidth: .infinity)
        }
    }
    
    private var sectionContents: some View {
        VStack(spacing: GuideAlertConstant.sectionVspacing, content: {
            ForEach(strategy.sections.enumerated(), id: \.offset) { idx, section in
                sectionGenerate(section)
                
                if idx == strategy.sections.count - 2 {
                    Divider()
                        .foregroundStyle(.g2)
                }
            }
        })
    }
    
    // MARK: FirstSection
    /// 섹션 생성 뷰
    /// - Parameter section: 섹션 값
    /// - Returns: 섹션 생성
    private func sectionGenerate(_ section: GuideSection) ->  some View {
        VStack(alignment: .leading, spacing: GuideAlertConstant.sectionInnerVspacing, content: {
            Text(sectionTitle(section.title))
                .font(.Subtitle3_SM)
                .foregroundStyle(.g7)
            
            Text(strategy.sections.first?.description ?? "")
                .font(.body3)
                .foregroundStyle(.g6)
        })
    }
    
    /// 섹션 내부 타이틀
    /// - Parameter title: 섹션 타이틀 값
    /// - Returns: 섹션 타이틀 String 반환
    private func sectionTitle(_ title: String) -> AttributedString {
        var str = AttributedString(title)
        if let range = str.range(of: GuideAlertConstant.checkText) {
            str[range].foregroundColor = .m6
            str[range].font = .Subtitle3_SM
        }
        return str
    }
}

#Preview {
    VisitAlert(strategy: VisitCheckStrategy(), dismissAction: {
        print("hello")
    })
}
