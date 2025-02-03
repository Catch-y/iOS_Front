//
//  PolygonDdata.swift
//  Catchy
//
//  Created by 정의찬 on 2/3/25.
//

import Foundation

struct PolygonData: Identifiable {
    let id: UUID
    var points: [CGPoint]
    let offset: CGPoint
    let scale: CGFloat
    let regionName: String
    let regionCode: String
    var center: CGPoint
}
