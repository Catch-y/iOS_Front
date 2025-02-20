//
//  DataFormatter.swift
//  Catchy
//
//  Created by 정의찬 on 1/14/25.
//

import Foundation
import SwiftUI

class DataFormatter {
    static let shared = DataFormatter()
    
    func makeStyledText(for text: String, with font: Font = .Subtitle2) -> AttributedString {
        var attributedString = AttributedString(text)
        
        if let nicknameRange = attributedString.range(of: UserState.shared.getUserNickname()) {
            attributedString[nicknameRange].foregroundColor = Color.main
            attributedString[nicknameRange].font = font
        }
        
        if let keywordRange = attributedString.range(of: "취향을 저격") {
            attributedString[keywordRange].foregroundColor = Color.main
            attributedString[keywordRange].font = .Subtitle2
        }
        
        if let keywordRange = attributedString.range(of: "TOP 10") {
            attributedString[keywordRange].foregroundColor = Color.main
            attributedString[keywordRange].font = .Subtitle2
        }
        
        if let keywordRange = attributedString.range(of: "비슷한 취향") {
            attributedString[keywordRange].foregroundColor = Color.main
            attributedString[keywordRange].font = .Subtitle2
        }
        
        if let keywordRange = attributedString.range(of: "딱 맞는 코스") {
            attributedString[keywordRange].foregroundColor = Color.main
            attributedString[keywordRange].font = .Subtitle1
        }
      
        if let keywordRange = attributedString.range(of: "방문 체크하기") {
            attributedString[keywordRange].foregroundColor = Color.main
            attributedString[keywordRange].font = .Subtitle3_SM
        }
        
        if let keywordRange = attributedString.range(of: "좋아요") {
            attributedString[keywordRange].foregroundColor = Color.main
            attributedString[keywordRange].font = .Subtitle2
        }
        
        if let keywordRange = attributedString.range(of: "리뷰를 등록 중") {
            attributedString[keywordRange].foregroundColor = Color.main
            attributedString[keywordRange].font = .Subtitle3_SM
        }
        
        if let keywordRange = attributedString.range(of: "코스를 생성 중") {
            attributedString[keywordRange].foregroundColor = Color.main
            attributedString[keywordRange].font = .Subtitle3_SM
        }

        
        return attributedString
    }
    
    /// 시간 반환 DataFormatter
    /// - Parameter date: 시간 데이터 입력
    /// - Returns: String 타입으로 반환
    func timeString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    /// 장소 이미지 구글 이미지로 반환
    /// - Parameter placeImageURL: json으로 받아온 구글 이미지 입력
    /// - Returns: 구글 키 값 포함된 이미지로 반환
    func formattedImageUrl(placeImageURL: String) -> String {
        let updateURLString = placeImageURL.replacingOccurrences(of: "key=GOOGLE_API_KEY", with: "key=\(Config.locationImageKey)")
        return updateURLString
    }
}
