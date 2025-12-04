//
//  String+Hightlight.swift
//  Catchy
//
//  Created by Apple Coding machine on 11/29/25.
//

import Foundation
import SwiftUI

extension String {
    func highlight(_ words: [(text: String, color: Color)]) -> AttributedString {
        var attr = AttributedString(self)
        attr.foregroundColor = .g7
        
        for word in words {
            if let range = attr.range(of: word.text) {
                attr[range].foregroundColor = word.color
            }
        }
        
        return attr
    }
}
