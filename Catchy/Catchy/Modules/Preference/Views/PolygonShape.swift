//
//  PolygonShape.swift
//  Catchy
//
//  Created by 정의찬 on 2/1/25.
//

import Foundation
import SwiftUI
import CoreGraphics

struct PolygonShape: Shape {
    let points: [CGPoint]
    let scale: CGFloat
    let offset: CGPoint

    func path(in rect: CGRect) -> Path {
        var path = Path()
        guard !points.isEmpty else { return path }

        path.move(to: CGPoint(
            x: (points[0].x - offset.x) * scale + rect.midX,
            y: (points[0].y - offset.y) * scale + rect.midY
        ))

        for point in points.dropFirst() {
            path.addLine(to: CGPoint(
                x: (point.x - offset.x) * scale + rect.midX,
                y: (point.y - offset.y) * scale + rect.midY
            ))
        }
        path.closeSubpath()
        return path
    }
}
