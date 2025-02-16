//
//  ScreenWidth.swift
//  Catchy
//
//  Created by 정의찬 on 2/17/25.
//

import Foundation
import SwiftUI

extension UIScreen {
    static var screenWidth: CGFloat {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.screen.bounds.width ?? 375
    }
}
