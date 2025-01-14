//
//  ImagePicker.swift
//  Catchy
//
//  Created by 정의찬 on 1/14/25.
//

import Foundation
import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.dismiss) var dismiss
    var imageHandler: ImageHandling
    var selectedLimit: Int
    
    func makeUIViewController(context: Context) -> some UIViewController {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.selectionLimit = selectedLimit
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self, imageHandler: imageHandler)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePicker
        var imageHandler: ImageHandling
        
        init(parent: ImagePicker, imageHandler: ImageHandling) {
            self.parent = parent
            self.imageHandler = imageHandler
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            self.parent.dismiss()
            
            for result in results {
                result.itemProvider.loadObject(ofClass: UIImage.self) { (object, error) in
                    if let image = object as? UIImage {
                        DispatchQueue.main.async {
                            self.imageHandler.addImage(image)
                        }
                    }
                }
            }
        }
    }
}
