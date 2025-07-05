//
//  resizeImage.swift
//  Catchy
//
//  Created by 정의찬 on 2/19/25.
//

import Foundation
import UIKit

extension UIImage {
    func resizeImage(to size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
