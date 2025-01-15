//
//  CategoryTagView.swift
//  Catchy
//
//  Created by LEE on 1/16/25.
//

import UIKit
import SwiftUI

/// 코스의 대 카테고리가 들어가는 태그입니다.
class CategoryTagView: UIView {

    // MARK: - Properties
    private let category: CategoryType
    
    // MARK: - UI Components
    private let textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.pretend(type: .semibold, size: 9)
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError( "init(coder:) has not been implemented" )
    }
    
    // MARK: - Init
    
    /// 대 카테고리에 맞춰 색상, 텍스트가 설정됩니다.
    /// - Parameter category: CategoryType의 enum 객체
    init(category: CategoryType){
        self.category = category
        
        self.textLabel.text = category.rawValue
        
        super.init(frame: .zero)
        
        switch category{
        case .cafe :
            self.backgroundColor = .cafe
           
        case .bar :
            self.backgroundColor = .bar
        case .restaurant :
            self.backgroundColor = .restaurant
        case .experience :
            self.backgroundColor = .experience
        case .culturalLife :
            self.backgroundColor = .culturaLife
        case .sport :
            self.backgroundColor = .sport
        case .rest :
            self.backgroundColor = .rest
            
        }
        
        self.configure()
        self.addComponents()
        self.setConstraints()
    
    }
    
    // MARK: - Configure Methods
    private func configure(){
        
        self.layer.cornerRadius = 5
        
    }
    
    // MARK: - Add Components & Set Constraints Methods
    private func addComponents(){
        
        [self.textLabel].forEach {
            self.addSubview($0)
        }
    }
    
    private func setConstraints(){
        
        /// 태그 뷰 자체 레이아웃
        self.snp.makeConstraints { make in
            make.width.equalTo(53)
            make.height.equalTo(20)
        }
        
        /// 텍스트의 레이아웃
        self.textLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

}

#Preview{
    CategoryTagView(category: .culturalLife)
}
