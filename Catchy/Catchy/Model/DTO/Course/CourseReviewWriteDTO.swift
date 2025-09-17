//
//  CourseReviewWriteDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation
import Moya

/// 코스 리뷰 작성
struct CourseReviewWritePath: Codable {
    let courseId: Int
}

struct CourseReviewWriteRequest: Codable {
    let comment: String
    let images: [Data]?
}

struct CourseReviewWriteResponse: Codable {
    let reviewId: Int
    let comment: String
    let reviewImages: [ReviewImage]
    let createdAt: String
    let creatorNickname: String
}

extension CourseReviewWriteRequest: MultipartConvertible {
    func asMultipartFormData() -> [MultipartFormData] {
        var builder = MultipartBuilder()
        
        let field: [String: CustomStringConvertible] = [
            "comment": comment
        ]
        
        field.forEach { key, value in
            builder.append(key, value: value)
        }
        
        if let images {
            for (index, image) in images.enumerated() {
                builder.append(
                    "images",
                    data: image,
                    fileName: "review_\(index).jpg",
                    mimeType: "image/jpg"
                )
            }
        }
        
        return builder.formData
    }
}
