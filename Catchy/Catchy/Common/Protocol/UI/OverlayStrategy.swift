//
//  OverlayStrategy.swift
//  Catchy
//
//  Created by euijjang97 on 12/8/25.
//

import Foundation

protocol OverlayStrategy {
     var overlayType: OverlayType { get }
 }

extension AlertStrategy {
    var overlayType: OverlayType { .twoButton }
}

extension GuideStrategy {
    var overlayType: OverlayType { .visit }
}

extension ChangeNicknameStrategy: OverlayStrategy {
    var overlayType: OverlayType { .nicknameChange }
}

extension GenerateVotwStrategy: OverlayStrategy {
    var overlayType: OverlayType { .voteParticipate }
}

extension LoadingGenerateStrategy: OverlayStrategy {
    var overlayType: OverlayType { .loading }
}

extension PollStrategy: OverlayStrategy {
    var overlayType: OverlayType { .coursePoll }
}

extension VisitCheckStrategy: OverlayStrategy {
    var overlayType: OverlayType { .visit }
}
