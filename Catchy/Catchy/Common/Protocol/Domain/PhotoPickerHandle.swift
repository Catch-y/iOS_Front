
//
//  PhotoPickerProtocol.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/19/25.
//

import Foundation
import SwiftUI

protocol PhotoPickerHandle: AnyObject {
    func addImage(_ images: [UIImage])
    func removeImage(at index: Int)
    func getImages() -> [UIImage]
    
    var isImagePickerPresented: Bool { get set }
    var selectedImageCount: Int { get }
}
