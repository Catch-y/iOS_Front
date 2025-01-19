//
//  FloatingButtonView.swift
//  Catchy
//
//  Created by LEE on 1/19/25.
//

import UIKit

class FloatingButtonView: UIView {
    
    // MARK: - UI Components Properties
    lazy var floatingButton: UIButton = {
        
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .main
        config.cornerStyle = .capsule
        config.image = Icon.add_clicked.uiImage
        button.configuration = config
        button.applyShadow(.S1W)
        return button
    }()
    
    lazy var DIYButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .white
        config.cornerStyle = .capsule
        config.image = Icon.courseDIY.uiImage
        button.configuration = config
        button.applyShadow(.S1W)
        return button
        
    }()
    
    lazy var DIYLabel : UILabel = {
        
        let label = UILabel()
        label.text = "코스 DIY"
        label.textColor = .white
        label.font = UIFont.body2
        return label
    }()
        
    lazy var AIButton: UIButton = {
        
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .white
        config.cornerStyle = .capsule
        config.image = Icon.courseAI.uiImage
        button.configuration = config
        button.applyShadow(.S1W)
        return button
        
    }()
    
    lazy var AILabel : UILabel = {
        
        let label = UILabel()
        label.text = "AI 추천 코스"
        label.textColor = .white
        label.font = UIFont.body2
        return label
        
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addComponents()
        self.setConstraints()
        
        self.backgroundColor = .black.withAlphaComponent(0.8)
        self.setupInitialButtonPositions()
        
        // 플로팅 버튼 간 Z축 설정. 메인 버튼이 가장 위에 오도록.
        self.floatingButton.layer.zPosition = 2
        self.AIButton.layer.zPosition = 1
        self.DIYButton.layer.zPosition = 0
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Add Components & Set Constraints Methods
    private func addComponents(){
        
        [
            self.DIYButton,
            self.floatingButton,
            self.AIButton,
            self.DIYLabel,
            self.AILabel,
        ].forEach{
            self.addSubview($0)
        }
        
    }
    
    private func setConstraints(){
                
        self.snp.makeConstraints{ make in
            make.width.equalTo(UIScreen.main.bounds.width)
        }
    
        self.floatingButton.snp.makeConstraints { make in
            make.width.height.equalTo(70)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(85)
        }
        
        self.AIButton.snp.makeConstraints { make in
            make.width.height.equalTo(70)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalTo(floatingButton.snp.top).offset(-10)
        }
        
        self.AILabel.snp.makeConstraints { make in
            make.right.equalTo(AIButton.snp.left).offset(-19)
            make.centerY.equalTo(AIButton)
            make.height.equalTo(20)
        }
        
        self.DIYButton.snp.makeConstraints { make in
            make.width.height.equalTo(70)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalTo(AIButton.snp.top).offset(-10)
            
        }
        
        self.DIYLabel.snp.makeConstraints { make in
            make.right.equalTo(DIYButton.snp.left).offset(-19)
            make.centerY.equalTo(DIYButton)
            make.height.equalTo(20)
        }
        
    }
    
    // MARK: - 초기 위치 설정 Method
    private func setupInitialButtonPositions() {
        
        self.AIButton.transform = CGAffineTransform(translationX: 0, y: 80)
        self.DIYButton.transform = CGAffineTransform(translationX: 0, y: 160)
        
        self.AILabel.transform = CGAffineTransform(translationX: 0, y: 80)
        self.DIYLabel.transform = CGAffineTransform(translationX: 0, y: 160)
    }
        
    // MARK: - Animation Method
    func animateButtons() {
        
        // AI 버튼 애니메이션
        UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseInOut, animations: {
            self.AIButton.transform = .identity // 원래 위치로 돌아옴
            self.AILabel.transform = .identity // 원래 위치로 돌아옴
        })
            
        // DIY 버튼 애니메이션
        UIView.animate(withDuration: 0.3, delay: 0.2, options: .curveEaseInOut, animations: {
            self.DIYButton.transform = .identity // 원래 위치로 돌아옴
            self.DIYLabel.transform = .identity // 원래 위치로 돌아옴
        })
    }

}
