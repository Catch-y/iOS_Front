//
//  SignUpViewModel.swift
//  Catchy
//
//  Created by 정의찬 on 1/14/25.
//

import Foundation
import SwiftUI

class SignUpViewModel: ObservableObject, ImageHandling {
    @Published var nickname: String = ""
    
    let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
    
    // MARK: - ImageProperty
    
    @Published var isImagePickerPresented: Bool = false
    @Published var selectedImageCount: Int = 0
    var profileImage: [UIImage] = []
    
    public func checkMainBtn() -> Bool {
        if profileImage.isEmpty {
            return false
        } else {
            if nickname.isEmpty {
                return false
            } else if nickname.count > 9 {
                return false
            } else {
                return true
            }
        }
    }
}

extension SignUpViewModel {
    func addImage(_ images: UIImage) {
        if !profileImage.isEmpty {
            profileImage.removeAll()
        }
        profileImage.append(images)
    }
    
    func getImages() -> [UIImage] {
        return profileImage
    }
    
    func removeImage(at index: Int) {
        profileImage.remove(at: index)
    }
    
    func showImagePicker() {
        self.isImagePickerPresented.toggle()
    }
}
