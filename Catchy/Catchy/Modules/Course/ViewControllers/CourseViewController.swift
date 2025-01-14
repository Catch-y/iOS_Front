//
//  CourseViewController.swift
//  Catchy
//
//  Created by LEE on 1/14/25.
//

import UIKit

class CourseViewController: UIViewController {
    

    // MARK: - UIView Properties
    
    /// 코스 탭 바 터치 시 나타나는 메인 화면
    private lazy var courseView: CourseView = {
        let courseView = CourseView()
        return courseView
    }()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.courseView
    }
    
}
