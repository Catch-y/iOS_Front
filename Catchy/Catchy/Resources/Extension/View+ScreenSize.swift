//
//  View+ScreenSize.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/18/25.
//

import Foundation
import SwiftUI

extension View {
    func getScreenSize() -> CGSize {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        return windowScene.screen.bounds.size
    }
}
