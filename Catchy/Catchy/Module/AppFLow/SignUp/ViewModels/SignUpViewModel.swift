//
//  SignUpViewModels.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/19/25.
//

import Foundation
import Combine
import PhotosUI
import SwiftUI

@Observable
class SignUpViewModel {
    // MARK: - StateProperty
    var isLoading: Bool = true
    var showPhotoPicker: Bool = false
    var checkBtn: Bool {
        if pickerImage == nil {
            return false
        } else {
            if nicknameAvail ?? false {
                return true
            } else {
                return false
            }
        }
    }
    
    // MARK: - Property
    var nickname: String = ""
    var nickanameMessage: String = ""
    var nicknameAvail: Bool?
    
    // MARK: - ImageProperty
    var pickerItem: PhotosPickerItem? = nil
    var pickerImage: UIImage?
    
    // MARK: - Depenedency
    let container: DIContainer
    let appFlow: AppFlow
    var cancellables: Set<AnyCancellable> = .init()
    
    // MARK: - Init
    init(container: DIContainer, appFlow: AppFlow) {
        self.container = container
        self.appFlow = appFlow
    }
    
    // MARK: - Method
    public func loadImage(_ item: PhotosPickerItem?) async {
        guard let item = item else { return }
        
        do {
            if let data = try await item.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                self.pickerImage = uiImage
                self.pickerItem = nil
            }
        } catch {
            print("이미지 로드 실패", error.localizedDescription)
        }
    }
}
