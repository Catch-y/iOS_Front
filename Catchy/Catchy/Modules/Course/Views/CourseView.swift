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

    // MARK: - Propertice
    @State private var selectedProvince: String = ""
    
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
    
    // TODO: - UIViewController에서 드랍다운 메뉴 아이템 전달할 수 있도록 수정해야함.
    /// 도 선택 드랍다운 메뉴
    private lazy var provinceDropDown: UIView = {
        
        let dropDownMenu = UIView.convert(from: DropDownView(
            selectedItem: $selectedProvince,
            placeholder: "도 선택",
            items: ["경상남도", "전라남도", "충청남도", "경상북도", "전라북도", "충청북도", "함경북도", "함경남도"],
            onItemSelected: {
                selectedItem in
                self.selectedProvince = selectedItem
            }
            
        ))
        
        return dropDownMenu
    }()
    
    // TODO: - UIViewController에서 드랍다운 메뉴 아이템 전달할 수 있도록 수정해야함.
    /// 시/군/구 선택 드랍다운 메뉴
    private lazy var districtDropDown: UIView = {
        let dropDownMenu = UIView.convert(from: DropDownView(
            selectedItem: $selectedProvince,
            placeholder: "시/군/구 선택",
            items: ["경상남도", "전라남도", "충청남도", "경상북도", "전라북도", "충청북도", "함경북도", "함경남도"],
            onItemSelected: {
                selectedItem in
                self.selectedProvince = selectedItem
            }
            
        ))
        
        return dropDownMenu
    }()
    
    /// 코스 셀이 있을 테이블 뷰
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CourseListCell.self, forCellReuseIdentifier: CourseListCell.identifier)
        return tableView
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
        
        [
            self.logoNavigationView,
            self.segmentControl,
            self.segmentLineView,
            self.provinceDropDown,
            self.districtDropDown,
            self.tableView
        ].forEach{
            self.addSubview($0)
        }
        
    }
    
    private func setConstraints(){
                
        self.snp.makeConstraints{ make in
            make.width.equalTo(UIScreen.main.bounds.width)
        }
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
        
        // 도 전체 옵션
        self.provinceDropDown.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(segmentLineView.snp.bottom).offset(22)
        }
        
        // 시/군/구 전체 옵션
        self.districtDropDown.snp.makeConstraints{ make in
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(segmentLineView.snp.bottom).offset(22)
        }
        
        // 테이블 뷰 설정
        self.tableView.snp.makeConstraints{ make in
            make.top.equalTo(provinceDropDown.snp.bottom).offset(36)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
        
    }

}

#Preview{
    CourseView()
}
