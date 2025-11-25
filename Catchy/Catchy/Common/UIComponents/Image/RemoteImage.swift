//
//  RemoteImage.swift
//  Catchy
//
//  Created by Apple Coding machine on 11/25/25.
//

import SwiftUI
import Kingfisher

struct RemoteImage: View {
    typealias ContentMode = SwiftUI.ContentMode
    
    // MARK: - Property
    let urlString: String
    let size: CGSize
    let cornerRadius: CGFloat
    let contentMode: ContentMode
    
    // MARK: - Init
    init(
        urlString: String,
        size: CGSize,
        cornerRadius: CGFloat = 15,
        contentMode: ContentMode = .fit
    ) {
        self.urlString = urlString
        self.size = size
        self.cornerRadius = cornerRadius
        self.contentMode = contentMode
    }
    
    // MARK: - Body
    var body: some View {
        if let url = URL(string: urlString) {
            KFImage(url)
                .placeholder {
                    ProgressView()
                        .controlSize(.regular)
                }
                .retry(maxCount: 2, interval: .seconds(2))
                .downsampling(size: size)
                .aspectRatio(contentMode: contentMode)
                .frame(maxWidth: .infinity, maxHeight: size.height)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        }
    }
}
