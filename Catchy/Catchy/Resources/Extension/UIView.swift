//
//  UIView.swift
//  Catchy
//
//  Created by LEE on 1/16/25.
//

import UIKit
import SwiftUI


extension UIView {
    
    /// SwiftUI -> UIKit으로 변환하는 메소드
    /// - Parameter swiftUIView: SwiftUI의 View 객체
    /// - Returns: UIKit의 UIView 객체 반환
    static func convert<Content: View>(from swiftUIView: Content) -> UIView {
        let hostingController = UIHostingController(rootView: swiftUIView)
        hostingController.view.backgroundColor = .clear
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        return hostingController.view
    }
}
