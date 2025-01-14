//
//  MainHeaderView.swift
//  Catchy
//
//  Created by LEE on 1/14/25.
//

import UIKit
import SwiftUI


/// 상단의 "catch:y" 로고가 있는 헤더 뷰
class MainHeaderView: UIView {
    
    // MARK: - UIView Properties
    
    // TODO: - Catch:y 로고 헤더 뷰 구현
    private lazy var imageView: UIImageView = {

        let imageView = UIImageView(image: UIImage(named: "logo_black"))
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return imageView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Add Components & Set Constraints Methods
    private func addComponents() {
        [self.imageView].forEach {
            self.addSubview( $0 )
        }
    }
    
    private func setConstraints(){
        
        self.imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(22)
        }
    }
}
