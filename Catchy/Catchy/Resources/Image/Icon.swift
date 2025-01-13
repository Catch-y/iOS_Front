//
//  SwiftAPITarget.swift
//  Catchy
//
//  Created by 정의찬 on 1/11/25.
//

import Foundation
import SwiftUI

enum Icon: String {
    case test = "Test"
    
    var image: Image {
        return Image(self.rawValue)
    }
}
