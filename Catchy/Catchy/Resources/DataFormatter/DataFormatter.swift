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
    
    func makeStyledText(for text: String) -> AttributedString {
        var attributedString = AttributedString(text)
        
        if let nicknameRange = attributedString.range(of: UserState.shared.getUserNickname()) {
            attributedString[nicknameRange].foregroundColor = Color.main
            attributedString[nicknameRange].font = .Subtitle2
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
        
        return attributedString
    }
    
    func timeString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}
