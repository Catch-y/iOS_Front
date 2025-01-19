//
//  CategoryTagCell.swift
//  Catchy
//
//  Created by LEE on 1/19/25.
//

import UIKit

class CategoryTagCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "CategoryTagCell"
    
    // MARK: - UI Components Properties
    private let textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.pretend(type: .semibold, size: 6)
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError( "init(coder:) has not been implemented" )
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addComponents()
        self.setConstraints()
        self.layer.cornerRadius = 4
    }
    
    // MARK: - Add Components & Set Constraints Methods
    private func addComponents(){
        
        [self.textLabel].forEach {
            self.addSubview($0)
        }
    }
    
    private func setConstraints(){
        
        /// 텍스트의 레이아웃
        self.textLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    /// 카테고리에 맞게 색상 업데이트
    /// - Parameter category: 해당 코스의 카테고리
    func configure(with category: CategoryType){
        self.textLabel.text = category.rawValue
        
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
        
    }
}
