//
//  PlaceReviewDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation
import Moya

/// 장소 평점/리뷰 달기
struct PlaceReviewPath: Codable {
    let placeId: Int
}

struct PlaceReviewRequest: Codable {
    let rating: Int
    let comment: String
    let visitedDate: String
    let images: [Data]?
}

struct PlaceReviewResponse: Codable {
    let reviewId: Int
    let comment: String
    let rating: Int
    let reviewImages: [ReviewImage]
    let visitedDate: String
    let creatorNickname: String
}


struct ReviewImage: Codable, Identifiable {
    var id: UUID = .init()
    let reviewImageId: Int
    let imageUrl: String
    
    enum CodingKeys: CodingKey {
        case reviewImageId
        case imageUrl
    }
}

extension PlaceReviewRequest: MultipartConvertible {
    func asMultipartFormData() -> [MultipartFormData] {
        var builder = MultipartBuilder()
        
        let fields: [String: CustomStringConvertible] = [
            "rating": rating,
            "comment": comment,
            "visitedDate": visitedDate,
        ]
        
        fields.forEach { key, value in
            builder.append(key, value: value)
        }
        
        if let images {
            for (index, image) in images.enumerated() {
                builder.append(
                    "images",
                    data: image,
                    fileName: "review_\(index).jpg",
                    mimeType: "image/jpeg"
                )
            }
        }
        
        return builder.formData
    }
}
