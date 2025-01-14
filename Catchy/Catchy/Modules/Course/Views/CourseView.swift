//
//  CourseView.swift
//  Catchy
//
//  Created by LEE on 1/14/25.
//

import UIKit
import SnapKit

class CourseView: UIView {

    
    // MARK: - UIView Properties
    
    /// "catch:y" 로고 헤더 뷰
    private lazy var mainHeaderView: MainHeaderView = {
        let headerView = MainHeaderView()
        return headerView
    }()
    
    /// 세그먼트 컨트롤
    public lazy var segmentControl: CourseSegmentControl = {
       
        let items = ["코스 DIY", "AI 추천"]
        let segmentControl = CourseSegmentControl(items: items)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentControl
        
    }()
    
    private lazy var segmentLineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.g2
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        return lineView
    }()
    
    
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
        
        [self.mainHeaderView, self.segmentControl, self.segmentLineView].forEach{ self.addSubview($0) }
        
    }
    
    private func setConstraints(){
        
        self.mainHeaderView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.width.equalToSuperview()
            make.height.equalTo(70)
        }
        
        self.segmentControl.snp.makeConstraints{ make in
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.top.equalTo(mainHeaderView.snp.bottom)
        
        }
        
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
