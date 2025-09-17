//
//  Encodable+Multpart.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/17/25.
//

import Foundation
import Moya

extension Encodable {
    func multipartFormParts(
        jsonFieldName: String,
        image: Data?,
        imageFieldName: String = "profileImage",
        fieldNamePrefix: String = "image",
        jsonFileName: String = "request.json"
    ) -> [MultipartFormData] {
        var parts: [MultipartFormData] = []
        
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .useDefaultKeys
        
        if let jsonData = try? encoder.encode(self) {
            let jsonPart = MultipartFormData(
                provider: .data(jsonData),
                name: jsonFieldName,
                fileName: jsonFileName,
                mimeType: "application/json"
            )
            parts.append(jsonPart)
        }
        
        if let image = image {
            let part = MultipartFormData(
                provider: .data(image),
                name: imageFieldName,
                fileName: "\(imageFieldName).jpg",
                mimeType: "image/jpeg"
                )
            parts.append(part)
        }
        return parts
    }
}
