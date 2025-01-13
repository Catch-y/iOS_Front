//
//  UIImage.swift
//  Catchy
//
//  Created by 정의찬 on 1/13/25.
//

import ImageIO
import UIKit


extension UIImage {
    /* DownSample Sacle 값 0.7로 사용하기 */
    func downSample(scale: CGFloat) -> UIImage {
        _ = [kCGImageSourceShouldCache: false] as CFDictionary
            let data = self.pngData()! as CFData
            let imageSource = CGImageSourceCreateWithData(data, nil)!
            let maxPixel = max(self.size.width, self.size.height) * scale
            let downSampleOptions = [
                kCGImageSourceCreateThumbnailFromImageAlways: true,
                kCGImageSourceShouldCacheImmediately: true,
                kCGImageSourceCreateThumbnailWithTransform: true,
                kCGImageSourceThumbnailMaxPixelSize: maxPixel
            ] as CFDictionary

            let downSampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downSampleOptions)!

            let newImage = UIImage(cgImage: downSampledImage)
            return newImage
        }
}
