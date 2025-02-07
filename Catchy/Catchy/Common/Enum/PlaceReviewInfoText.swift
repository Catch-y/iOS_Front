//
//  PlaceReviewInfoText.swift
//  Catchy
//
//  Created by LEE on 2/7/25.
//

import Foundation


/// 장소 리뷰, 평점 뷰의 텍스트 에디터에서 사용
enum PlaceReviewInfoText: CaseIterable {
    
    case one
    case two
    case three
    case four
    
    /// 보라색 텍스트
    var infoText: String {
        switch self {
        case .one:
            return "장소의 분위기나 특징은 어땠나요?"
        case .two:
            return "어떤 점을 추천해주고 싶으신가요?"
        case .three:
            return "방문 시 주의할 점이 있나요?"
        case .four:
            return "기억에 남는 특별한 경험이 있으신가요?"
        }
    }
    
    /// placeholder 텍스트
    static var placeholder: String {
        
    """
    방문한 장소에 대한 소중한 리뷰를 남겨 보세요!   작성한 리뷰는 다른 사용자들에게 유용한 정보를 제공하며,   다음 방문을 위한 기록으로도 활용할 수 있습니다.  [리뷰에 포함되면 좋은 내용] - 장소의 분위기와 특징 - 추천하거나 주의할 점 - 기억에 남는 특별한 경험  여러분의 리뷰가 더 나은 코스를 만드는 데 큰 도움이 됩니다!
    """
        
        
    }
    
    /// 케이스 중 랜덤 텍스트를 리턴
    static var randomText: String {
        return self.allCases.randomElement()?.infoText ?? ""
    }
    
    
    
}
