//
//  UIKitShadowReuse.swift
//  Catchy
//
//  Created by LEE on 1/16/25.
//

import Foundation
import UIKit

enum Shadow{
    case S1W
    case S2T
    case S3T
    case S4B
}

extension UIView {
    
    
    /// UIKit에서 에셋 내 그림자 적용하는 메소드
    /// - Parameter shadow: figma에 명시된 값 전달
    ///
    /// view = UIView()
    /// view.applyShadow(.S1W)
    func applyShadow(_ shadow: Shadow){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        switch shadow {
        case .S1W:
            self.layer.shadowOpacity = 0.15
            self.layer.shadowRadius = 5
            
        case .S2T:
            self.layer.shadowOpacity = 0.6
            self.layer.shadowRadius = 3
        case .S3T:
            self.layer.shadowOpacity = 0.3
            self.layer.shadowRadius = 2.5
        case .S4B:
            self.layer.shadowOpacity = 0.2
            self.layer.shadowRadius = 2
        }
    }
}
