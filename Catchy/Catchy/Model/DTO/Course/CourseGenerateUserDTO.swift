//
//  CourseGenerateDIYDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation
import Moya

/// 코스 유저 생성
struct CourseGenerateUserRequest: Codable {
    let courseName: String
    let courseDescription: String
    let placeIds: [Int]?
    let courseImage: Data?
    let recommendTimeStart: String
    let recommendTimeEnd: String
}

struct CourseGenerateUserResponse: Codable, Equatable {
    let courseId: Int
    let courseImage: String
    let courseName: String
    let courseDescription: String
    let courseType: CourseType
    let rating: Double
    let reviewCount: Int
    let recommendTime: String
    let participantsNumber: Int
    let isBookMarked: Bool
    let placeInfos: [PlaceInfo]
}

struct PlaceInfo: Codable, Identifiable, Equatable {
    var id: UUID = .init()
    let placeId: Int
    let placeName: String
    let category: CategoryType
    let placeLatitude: Double
    let placeLongitude: Double
    let isVisited: Bool
    
    enum CodingKeys: CodingKey {
        case placeId
        case placeName
        case category
        case placeLatitude
        case placeLongitude
        case isVisited
    }
}

extension CourseGenerateUserRequest: MultipartConvertible {
    func asMultipartFormData() -> [MultipartFormData] {
        var builder = MultipartBuilder()
        
        let fields: [String: CustomStringConvertible] = [
            "courseName": courseName,
            "courseDescription": courseDescription,
            "recommendTimeStart": recommendTimeStart,
            "recommendTimeEnd": recommendTimeEnd
        ]
        
        fields.forEach { key, value in
            builder.append(key, value: value)
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
