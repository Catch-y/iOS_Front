//
//  MultipartConvertible.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/11/25.
//

import Foundation
import Moya

protocol MultipartConvertible {
    func asMultipartFormData() -> [MultipartFormData]
}
