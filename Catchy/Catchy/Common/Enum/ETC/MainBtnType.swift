//
//  MainBtnType.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/19/25.
//

import SwiftUI

enum MainBtnOnOff {
    case on
    case off
    case custom
    
    var btnColor: Color {
        switch self {
        case .on:
            return Color.m5
        case .off:
            return Color.g2
        case .custom:
            return Color.white
        }
    }
    
    var textColor: Color {
        switch self {
        case .on:
            return Color.white
        case .off:
            return Color.g4
        case .custom:
            return Color.m5
        }
    }
    
    var borderColor: Color? {
        switch self {
        case .on:
            return nil
        case .off:
            return nil
        case .custom:
            return Color.m5
        }
    }
}

enum MainBtnType {
    case check(onOff: MainBtnOnOff)
    case voteResultCheck
    case next(onOff: MainBtnOnOff)
    case select(onOff: MainBtnOnOff)
    case changeHome(onOff: MainBtnOnOff)
    case searchRoad
    case reviewWrite
    case courseInclude(onOff: MainBtnOnOff)
    case change(onOff: MainBtnOnOff)
    case participate(onOff: MainBtnOnOff)
    case report(onOff: MainBtnOnOff)
    case cancel(onOff: MainBtnOnOff)
    case voteComplete(onOff: MainBtnOnOff)
    
    var text: String {
        switch self {
        case .check:
            return "확인"
        case .voteResultCheck:
            return "투표 결과 확인하기"
        case .next:
            return "다음"
        case .select:
            return "선택"
        case .searchRoad:
            return "길 찾기"
        case .reviewWrite:
            return "리뷰 남기기"
        case .courseInclude:
            return "코스에 담기"
        case .change:
            return "변경하기"
        case .participate:
            return "참여하기"
        case .report:
            return "신고하기"
        case .cancel:
            return "취소하기"
        case .voteComplete:
            return "투표 참여하기"
        case .changeHome:
            return "홈으로 넘어가기"
        }
    }
    
    var onOff: MainBtnOnOff {
        switch self {
        case .check(let onOff),
                .next(let onOff),
                .select(let onOff),
                .courseInclude(let onOff),
                .change(let onOff),
                .report(let onOff),
                .cancel(let onOff),
                .voteComplete(let onOff),
                .participate(let onOff),
                .changeHome(let onOff):
            return onOff
        default:
            return .on
        }
    }
    
}
