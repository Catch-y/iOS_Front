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

class DIYCourseCreateViewModel: ObservableObject {
    
    let container: DIContainer
    
    var cancellables = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    // MARK: - 코스 생성하기 화면 Properties
    /// 코스 이름
    @Published var courseName: String = ""
    
    /// 코스 상세 설명
    @Published var courseDescription: String = ""
    
    /// 코스 이미지
    @Published var courseImage: UIImage? = nil
    
    /// 왼쪽 시간
    @Published var leftSelectedTime: Date? = nil
    
    /// 오른쪽 시간
    @Published var rightSelectedTime: Date? = nil
    
    /// 열려있는 상태
    @Published var isExpand: [Int:Bool] = [0: false, 1: false]
}


