//
//  FloatingButtonViewController.swift
//  Catchy
//
//  Created by LEE on 1/19/25.
//

import UIKit

class FloatingButtonViewController: UIViewController {

    // MARK: UI Component Properties
    private lazy var floatingButtonView = FloatingButtonView()
    
    // MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()

        view = floatingButtonView
        
        floatingButtonView.floatingButton.addTarget(self, action: #selector(didTapFloatingButton), for: .touchUpInside)
        
        floatingButtonView.AIButton.addTarget(self, action:
            #selector(didTapAIButton), for: .touchUpInside)
        
        floatingButtonView.DIYButton.addTarget(self, action: #selector(didTapDIYButton), for: .touchUpInside)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        floatingButtonView.animateButtons()
    }
    
    // MARK: - Handler Methods
    
    @objc func didTapFloatingButton(){
        
        dismiss(animated: false)
    }
    
    // TODO: - DIY 버튼 탭 시
    @objc func didTapDIYButton(){
        
        
    }
    
    // TODO: - AI 추천 코스 탭 시
    @objc func didTapAIButton(){
        
    }

}
