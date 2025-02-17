//
//  DIYCourseCreateViewModel.swift
//  Catchy
//
//  Created by LEE on 2/17/25.
//

import Foundation
import SwiftUI
import Combine
import CombineMoya

class DIYCourseCreateViewModel: ObservableObject, ImageHandling {
    
    let container: DIContainer
    
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(container: DIContainer) {
        self.container = container
    }
    
    // MARK: - 코스 생성하기 화면 Properties
    /// 코스 이름
    @Published var courseName: String = ""
    
    /// 코스 상세 설명
    @Published var courseDescription: String = ""
    
    /// 코스 이미지
    @Published var courseImage: [UIImage] = [] {
        didSet {
            selectedImageCount = self.courseImage.count
        }
    }
    
    /// 왼쪽 시간
    @Published var leftSelectedTime: Date? = nil
    
    /// 오른쪽 시간
    @Published var rightSelectedTime: Date? = nil
    
    /// 열려있는 상태
    @Published var isExpand: [Int:Bool] = [0: false, 1: false]
    
    /// 이미지 피커 화면 상태
    @Published var isImagePickerPresented: Bool = false
    
    /// 업로드한 이미지 개수
    @Published var selectedImageCount: Int = 0

    
}

// MARK: - Extensinon
extension DIYCourseCreateViewModel {
    
    func addImage(_ courseImage: UIImage) {
        guard self.courseImage.isEmpty else { return }
        self.courseImage.append(courseImage)
    }
    
    func removeImage(at index: Int) {
        guard !self.courseImage.isEmpty else { return }
        self.courseImage.remove(at: index)
    }
    
    func showImagePicker() {
        self.isImagePickerPresented.toggle()
    }
    
    func getImages() -> [UIImage] {
        self.courseImage
    }
    
    func canCreateCourse() -> Bool {
        let trimmedName = courseName.trimmingCharacters(in: .whitespaces)
        let trimmedDescription = courseDescription.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return trimmedName.count > 0 && trimmedDescription.count > 0 && leftSelectedTime != nil && rightSelectedTime != nil 
    }

}

