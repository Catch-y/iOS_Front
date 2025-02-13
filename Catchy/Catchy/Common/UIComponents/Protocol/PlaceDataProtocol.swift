//
//  PlaceDataProtocol.swift
//  Catchy
//
//  Created by 권용빈 on 2/5/25.
//

import Foundation

/// `PlaceCard`에서 공통적으로 사용할 속성을 정의한 프로토콜
protocol PlaceDataProtocol {
    var placeId: Int { get }
    var placeName: String { get }
    var placeImage: String { get }  // `imageUrl`도 대응
    var category: CategoryType { get }  // `categoryName`도 대응
    var roadAddress: String { get }
    var activeTime: String { get }
    var rating: Double { get }
    var reviewCount: Int { get }
}
