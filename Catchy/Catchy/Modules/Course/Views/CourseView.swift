//
//  CourseView.swift
//  Catchy
//
//  Created by LEE on 1/14/25.
//

import UIKit
import SwiftUI
import SnapKit

class CourseView: UIView {

    
    // MARK: - UIView Properties
    /// 로고 네비게이션 바
    /// SwiftUI객체를 UIKit에서 사용하기 위해 UIHostingController 객체로 감쌈
    private lazy var logoNavigationView: UIView = {
        let logoView = CustomLogoNavi(onlyLogo: true)
        let hostingController = UIHostingController(rootView: logoView)
        
        // 배경색 투명하개
        hostingController.view.backgroundColor = .clear
        
        // TODO: - 네비게이션 바 상단의 그림자만 제거해야함
        // 상하단 그림자 모두 제거
        hostingController.view.layer.masksToBounds = true
        
        return hostingController.view
    }()
    
    /// 세그먼트 컨트롤
    public lazy var segmentControl: CourseSegmentControl = {
       
        let items = ["코스 DIY", "AI 추천"]
        let segmentControl = CourseSegmentControl(items: items)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentControl
        
    }()
    
    /// 세그먼트 컨트롤 하단 뷰
    private lazy var segmentLineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.g2
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        return lineView
    }()
    
    private lazy var provinceDropDown:
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addComponents()
        self.setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Add Components & Set Constraints Methods
    
    private func addComponents(){
        
        [
            self.logoNavigationView,
            self.segmentControl,
            self.segmentLineView
        ].forEach{
            self.addSubview($0)
        }
        
    }
    
    private func setConstraints(){
        
        // Catch:y 로고 네비게이션 뷰 레이아웃
        self.logoNavigationView.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
        }
        
        // 세그먼트 컨트롤 레이아웃
        self.segmentControl.snp.makeConstraints{ make in
            make.height.equalTo(45)
            make.width.equalTo(350)
            make.left.right.equalToSuperview()
            make.top.equalTo(logoNavigationView.snp.bottom)
        }
        
        // 세그먼트 컨트롤 하단 선 래이아웃
        self.segmentLineView.snp.makeConstraints{ make in
            make.height.equalTo(1)
            make.centerX.equalToSuperview()
            make.top.equalTo(segmentControl.snp.bottom).offset(-1)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        
    }

}

#Preview{
    CourseView()
}
