//
//  PolygonShape.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/19/25.
//

import Foundation
import SwiftUI

struct PolygonShape: Shape {
    let points: [CGPoint]
    let scale: CGFloat
    let offset: CGPoint
    
    nonisolated func path(in rect: CGRect) -> Path {
        var path = Path()
        guard !points.isEmpty else { return path }
        
        path.move(to: .init(
            x: (points[0].x - offset.x) * scale + rect.midX,
            y: (points[0].y - offset.y) * scale + rect.midY
        ))
        
        for point in points.dropFirst() {
            path.addLine(to: .init(
                x: ((point.x - offset.x) * scale + rect.midX,),
                y: ((point.y - offset.y) * scale + rect.midY)
            ))
        }
        path.closeSubpath()
        return path
    }
}
