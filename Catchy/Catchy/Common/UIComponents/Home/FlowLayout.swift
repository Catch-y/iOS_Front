//
//  FlowLayout.swift
//  Catchy
//
//  Created by 정의찬 on 1/15/25.
//

import Foundation
import SwiftUI

struct FlowLayout<Content: View>: View {
    let tags: [String]
    let content: (String) -> Content


    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
        .frame(maxWidth: .infinity)
    }

    private func generateContent(in geometry: GeometryProxy) -> some View {
        var width: CGFloat = 0
        var rows: [[String]] = [[]]

        for tag in tags {
            let tagWidth = tag.width(usingFont: .systemFont(ofSize: 14)) + 16
            if width + tagWidth > geometry.size.width {
                width = tagWidth
                rows.append([tag])
            } else {
                width += tagWidth
                rows[rows.count - 1].append(tag)
            }
        }

        return VStack(alignment: .leading, spacing: 8) {
            ForEach(rows, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(row, id: \.self) { tag in
                        content(tag)
                    }
                }
            }
        }
    }
}
