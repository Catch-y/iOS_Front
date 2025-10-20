//
//  CourseGenerateAIDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 코스 AI 생성
struct CourseGenerateAIResponse: Codable {
    let courseId: Int
    let courseName: String
    let courseDescription: String
    let recommendTime: String
    let courseImage: String
    let courseRating: Double
    let placeInfos: [PlaceInfo]
    
    struct PlaceInfo: Codable {
        let placeId: Int
        let placeName: String
        let placeImage: String
        let category: String
        let roadAddress: String
        let activeTime: String
        let rating: Double
        let reviewCount: Int
    }
}
