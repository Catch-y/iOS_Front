//
//  ReviewDataProtocol.swift
//  Catchy
//
//  Created by 권용빈 on 2/7/25.
//

import Foundation

protocol ReviewDataProtocol {
    var reviewId: Int { get }
    var rating: Int { get }
    var images: [ReviewImageProtocol] { get }
    var comment: String { get }
    var userName: String? { get }
    var placeOrCourseName: String? { get }
    var visitedDate: String { get }
}

protocol ReviewImageProtocol {
    var reviewImageId: Int { get }
    var imageUrl: String { get }
}
