//
//  AlertModifier.swift
//  Catchy
//
//  Created by euijjang97 on 12/8/25.
//

import SwiftUI

struct AlertModifier: ViewModifier {
    @Bindable var alert: AppAlert
    
    func body(content: Content) -> some View {
              content
                  .overlay {
                      if alert.isPresented {
                          Color.black.opacity(0.4)
                              .ignoresSafeArea()
                              .onTapGesture {
                                  if alert.currentType != .loading {
                                      alert.dismiss()
                                  }
                              }

                          alertContent
                              .padding(.horizontal, DefaultConstants.defaultSafeHorizon)
                      }
                  }
          }
    
    @ViewBuilder
    private var alertContent: some View {
        switch alert.currentType {
        case .twoButton:
            if let strategy = alert.alertStrategy {
                TwoButtonAlert(strategy: strategy)
            }
        case .nicknameChange:
            if let strategy = alert.alertStrategy {
                NicknameChangeAlert(strategy: strategy, btnOnOff: alert.nicknameButtonEnabled)
            }
        case .visit:
            if let strategy = alert.guideStrategy {
                VisitAlert(strategy: strategy, dismissAction: alert.dismiss)
            }
        case .voteParticipate:
            if let strategy = alert.alertStrategy {
                VoteParticipateAlert(strategy: strategy)
            }
        case .coursePoll:
            if let strategy = alert.pollStrategy {
                CourePollAlert(strategy: PollStrategy(buttonType: strategy.buttonType)) { categories in
                    alert.pollCheckAction?(categories)
                    alert.dismiss()
                }
            }
        case .loading:
            if let strategy = alert.loadingStrategy {
                LoadingAlert(strategy: strategy)
            }
        case nil:
            EmptyView()
        }
    }
}

extension View {
    func catchyAlert(alert: AppAlert) -> some View {
        self.modifier(AlertModifier(alert: alert))
    }
}
