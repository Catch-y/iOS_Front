//
//  VoteParticipateAlert.swift
//  Catchy
//
//  Created by Apple Coding machine on 10/22/25.
//

import SwiftUI

struct VoteParticipateAlert: View {
    // MARK: - Property
    @Environment(\.dismiss) var dismiss
    let strategy: AlertStrategy
    
    // MARK: - Constants
    fileprivate enum VoteParticipateAlertConstant {
        static let mainPadding: EdgeInsets = .init(top: 16, leading: 16, bottom: 34, trailing: 16)
        static let spacerValue: (CGFloat, CGFloat) = (23, 45)
        static let btnHeight: CGFloat = 56
        static let cornerRadius: CGFloat = 20
        static let lineSpacing: CGFloat = 2.5
    }
    
    // MARK: - Init
    init(strategy: AlertStrategy) {
        self.strategy = strategy
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            topContents
            Spacer().frame(height: VoteParticipateAlertConstant.spacerValue.0)
            middleContents
            Spacer().frame(height: VoteParticipateAlertConstant.spacerValue.1)
            bottomContents
        }
        .padding(VoteParticipateAlertConstant.mainPadding)
        .background {
            RoundedRectangle(cornerRadius: VoteParticipateAlertConstant.cornerRadius)
                .fill(.white)
                .frame(maxWidth: .infinity)
        }
    }
    
    // MARK: - Top
    private var topContents: some View {
        HStack {
            Spacer()
            CloseBtn(action: {
                dismiss()
            })
        }
    }
    
    // MARK: - Middle
    private var middleContents: some View {
        Text(strategy.title)
            .font(.subtitle3)
            .foregroundStyle(.g7)
            .multilineTextAlignment(.center)
            .lineSpacing(VoteParticipateAlertConstant.lineSpacing)
    }
    
    // MARK: - Bottom
    @ViewBuilder
    private var bottomContents: some View {
        if let btn = strategy.buttons?.first {
            MainButton(btnType: btn, height: VoteParticipateAlertConstant.btnHeight, action: {
                strategy.primaryAction()
            })
        }
    }
}

#Preview {
    VoteParticipateAlert(strategy: GenerateVotwStrategy(joinPoll: {
        print("참여")
    }))
}
