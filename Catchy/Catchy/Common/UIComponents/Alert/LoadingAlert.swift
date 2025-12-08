//
//  LoadingAlert.swift
//  Catchy
//
//  Created by Apple Coding machine on 10/20/25.
//

import SwiftUI

struct LoadingAlert: View {
    
    // MARK: - Property
    let strategy: LoadingGenerateStrategy
    
    // MARK: - Constant
    fileprivate enum LoadingAlertConstant {
        static let middleVspacing: CGFloat = 5
        static let mainVspacing: CGFloat = 25
        static let mainPadding: EdgeInsets = .init(top: 48, leading: 107, bottom: 55, trailing: 107)
        static let mainHeight: CGFloat = 218
        
        static let loadingCount: Int = 4
        static let cornerRadius: CGFloat = 20
        static let lineSpacing: CGFloat = 2.5
        
        static let generateText: String = "코스를 생성 중"
        static let waitingText: String = "잠시만 기다려주세요."
    }
    
    // MARK: - Init
    init(strategy: LoadingGenerateStrategy) {
        self.strategy = strategy
    }
    
    // MARK: - Body
    var body: some View {
        ZStack(content: {
            RoundedRectangle(cornerRadius: LoadingAlertConstant.cornerRadius)
                .fill(.white)
                .frame(maxWidth: .infinity)
                .frame(height: LoadingAlertConstant.mainHeight)
            
            VStack(spacing: .zero, content: {
                HorizonLoading()
                Spacer().frame(height: LoadingAlertConstant.mainVspacing)
                middleContents
            })
        })
    }
    
    // MARK: - Middle
    /// 중간 컨텐츠
    private var middleContents: some View {
        VStack(spacing: LoadingAlertConstant.middleVspacing, content: {
            Text(title)
                .font(.subtitle3_SM)
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
                .lineSpacing(LoadingAlertConstant.lineSpacing)
            
            Text(LoadingAlertConstant.waitingText)
                .font(.body3)
                .foregroundStyle(.g4)
        })
    }
    
    /// 중간 타이틀 텍스트
    private var title: AttributedString {
        var str = AttributedString(strategy.title)
        if let range = str.range(of: LoadingAlertConstant.generateText) {
            str[range].foregroundColor = .m6
            str[range].font = .subtitle3_SM
        }
        return str
    }
}

#Preview {
    LoadingAlert(strategy: LoadingGenerateStrategy())
}
