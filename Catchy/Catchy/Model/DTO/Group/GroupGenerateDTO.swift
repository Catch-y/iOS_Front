//
//  GroupGenerate.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation
import Moya

/// 그룹 생성
struct GroupGenerateRequest: Codable {
    let groupName: String
    let groupLocation: String
    let promiseTime: String
    let inviteCode: String
    let groupImage: Data?
}

struct GroupGenerateResponse: Codable {
    let groupId: Int
    let groupName: String
    let groupLocation: String
    let groupImage: String
    let inviteCode: String
    let promiseTime: String
    let creatorNickname: String
}

extension GroupGenerateRequest: MultipartConvertible {
    func asMultipartFormData() -> [MultipartFormData] {
        var builder = MultipartBuilder()
        
        let fields: [String: CustomStringConvertible] = [
            "groupName": groupName,
            "groupLocation": groupLocation,
            "promiseTime": promiseTime,
            "inviteCode": inviteCode
        ]
        
        fields.forEach { key, value in
            builder.append(key, value: value)
        }
        
        if let groupImage {
            builder.append(
                "groupImage",
                data: groupImage,
                fileName: "groupImage.jpg",
                mimeType: "image/jpeg")
        }
        
    }
}
