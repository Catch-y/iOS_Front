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

extension CourseReviewWriteRequest {
    func asMultipartForm() -> [MultipartFormData] {
        let stringParam: [String: String] = [
            "comment": comment
        ]
        
        var formData = stringParam.map {
            MultipartFormData(
                provider: .data($0.value.data(using: .utf8)!),
                name: $0.key)
        }
        
        if let images = images {
            for (index, image) in images.enumerated() {
                formData.append(
                    MultipartFormData(
                        provider: .data(image),
                        name: "images",
                        fileName: "image\(index).jpg",
                        mimeType: "images/jpeg"
                    )
                )
            }
        }
        
        return formData
    }
}
