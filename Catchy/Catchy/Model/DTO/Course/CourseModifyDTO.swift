//
//  CourseModifyDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation
import Moya

/// 코스 수정
struct CourseModifyPath: Codable {
    let courseId: Int
}

struct CourseModifyRequest: Codable {
    let courseName: String?
    let courseDescription: String?
    let placeIds: [Int]?
    let courseImage: Data?
    let recommendTimeStart: String?
    let recommendTimeEnd: String?
}

extension CourseModifyRequest: MultipartConvertible {
    func asMultipartFormData() -> [MultipartFormData] {
        var builder = MultipartBuilder()
        
        if let courseName {
            builder.append("courseName", value: courseName)
        }
        
        if let courseDescription {
            builder.append("courseDescription", value: courseDescription)
        }
        
        if let recommendTimeStart {
            builder.append("recommendTimeStart", value: recommendTimeStart)
        }
        
        if let recommendTimeEnd {
            builder.append("recommendTimeEnd", value: recommendTimeEnd)
        }
        
        if let placeIds {
            builder.appendArray("placeIds", value: placeIds)
        }
        
        if let courseImage {
            builder.append(
                "courseImage",
                data: courseImage,
                fileName: "courseImage.jpg",
                mimeType: "image/jpeg")
        }
        
        return builder.formData
    }
}
