//
//  MultipartBuilder.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/11/25.
//

import Foundation
import Moya

/// Moya의 MultipartFormData 구성 작업을 감싸는 빌더입니다.
/// 여러 개의 multipart 데이터를 누적하여 편리하게 생성할 수 있도록 도와줍니다.
struct MultipartBuilder {
    /// 누적된 multipart form 데이터들을 저장합니다.
    /// 외부에서 읽을 수 있으나 내부에서만 변경 가능합니다.
    private(set) var formData: [MultipartFormData] = .init()
    
    
    /// 간단한 문자열 필드를 추가합니다.
    /// value를 UTF-8 데이터로 변환하여 추가하며,
    /// 만약 UTF-8 변환에 실패하면 해당 필드는 무시됩니다.
    /// 값 넘기기
    mutating func append(_ name: String, value: CustomStringConvertible) {
        if let data = "\(value)".data(using: .utf8) {
            formData.append(.init(provider: .data(data), name: name)) // 텍스트 필드 파트로 추가
        }
    }
    
    /// 바이너리(파일) 데이터를 추가합니다.
    /// 파일명과 MIME 타입을 함께 지정하여 전송합니다.
    /// 이미지 추가 함수
    mutating func append(_ name: String, data: Data, fileName: String, mimeType: String) {
        formData.append(.init(
            provider: .data(data),
            name: name,        // 서버 필드명
            fileName: fileName, // 전송될 파일명
            mimeType: mimeType  // 콘텐츠 타입
        ))
    }
    
    /// 동일한 키에 대해 여러 값을 배열로 추가합니다.
    /// 예를 들어 tags[]와 같이 여러 값을 전송할 때 사용합니다.
    /// 백엔드에 따라 tags 또는 tags[] 형태를 요구할 수 있으니 주의하세요.
    mutating func appendArray<T: CustomStringConvertible>(_ name: String, value: [T]) {
        value.forEach { append(name, value: $0) }
    }
    
    /// 누적된 multipart 데이터를 배열로 반환합니다.
    /// 반환된 배열을 Moya의 .uploadMultipart 등에 사용할 수 있습니다.
    func build() -> [MultipartFormData] {
        formData
    }
}
