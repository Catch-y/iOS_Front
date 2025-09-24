//
//  String.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/24/25.
//

import Foundation
import SwiftUI

extension Date {
    func timeString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
}
