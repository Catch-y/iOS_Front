//
//  StringExtension.swift
//  Catchy
//
//  Created by 정의찬 on 1/15/25.
//

import Foundation
import SwiftUI

extension String {
    
    func width(usingFont font: UIFont) -> CGFloat {
        let attributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: attributes).width
    }
    
    func customLineBreak() -> String {
        return self.split(separator: "").joined(separator: "\u{200B}")
    }
    
}
