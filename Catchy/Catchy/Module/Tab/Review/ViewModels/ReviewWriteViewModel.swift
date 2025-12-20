//
//  ReviewWriteViewModel.swift
//  Catchy
//
//  Created by euijjang97 on 12/19/25.
//

import Foundation
import SwiftUI
import PhotosUI

@Observable
class ReviewWriteViewModel {
    // MARK: - StateProperty
    var showPhotoPicker: Bool = false
    
    // MARK: - Property
    var dropValues: [String] = ["2025.01.13","2025.01.14","2025.01.15"]
    var selectedDropValue: String? = nil
    var currentRating: Int = 0
    var placeReviewText: String = ""
    
    // MARK: - Image
    var images: [UIImage] = .init()
    var selectedItems: [PhotosPickerItem] = .init()
    
    // MARK: - Dependencies
    private let container: DIContainer
    
    // MARK: - Init
    init(container: DIContainer) {
        self.container = container
    }
}

// MARK: - Photo Methods
extension ReviewWriteViewModel {
    func loadIamges(from items: [PhotosPickerItem]) async {
        for item in items {
            if let data = try? await item.loadTransferable(type: Data.self),
               let image = UIImage(data: data) {
                await MainActor.run(body: {
                    self.images.append(image)
                })
            }
        }
        
        await MainActor.run(body: {
            self.selectedItems.removeAll()
        })
    }
    
    func removeImage(at index: Int) {
        guard images.indices.contains(index) else { return }
        images.remove(at: index)
    }
}
