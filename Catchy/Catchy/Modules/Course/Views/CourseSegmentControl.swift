//
//  CourseSegmentControl.swift
//  Catchy
//
//  Created by LEE on 1/14/25.
//

import UIKit

// 코스 뷰 컨트롤러 내부 세그먼트 컨트롤
class CourseSegmentControl: UISegmentedControl {

    
    // MARK: - Design Properties
    
    /* 폰트 */
    private let font = UIFont.pretend(type: .semibold, size: 15)
    
    /* 선택된 상태 색상 */
    private let selectedColor : UIColor = .main
    
    /* 선택 안된 상태 색상 */
    private let normalColor : UIColor = .g4
    
    /* 바 길이 계산 */
    private lazy var maxSegmentLabelWidth: CGFloat = {
        
        var maxWidth: CGFloat = 0
        
        /// 세그먼트 아이템의 레이블 중 가장 긴 길이 반환.
        for index in 0..<self.numberOfSegments{
            guard let text = self.titleForSegment(at: index) else { continue }
            
            let attributes: [NSAttributedString.Key : Any] = [.font: self.font]
            
            let textSize = (text as NSString).size(withAttributes: attributes)
            
            maxWidth = max(maxWidth, textSize.width)
            
        }

        return maxWidth
    }()
    
    // MARK: - UIView Properties

    /// 세그먼트 컨트롤러가 가지는 하단 바 커스텀을 위한 UIView
    private let selectedIndicator = UIView()
    
    /// 하단 바 위치의 선을 위한 UIView
    private let segmentLine = UIView()
    
    // MARK: - Properties
    
    /// 세그먼트 컨트롤러가 탭 될 때, 뷰 컨트롤러의 핸들러 함수
    private var onSegementChange : ((Int) -> Void)?
    
    // MARK: - Init
    
    init(items: [String]){
        super.init(items: items)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateIndicatorPosition()
    }
    
    // MARK: - Configure Methods
    
    private func configure(){
        
        self.configureFonts()
        self.configureColors()
        self.addTarget(self, action: #selector(didTapSegmentControl), for: .valueChanged)
        self.selectedSegmentIndicator()
    }
    
    /// 세그먼트 컨트롤의 폰트를 구성합니다.
    private func configureFonts(){
        
        /* 선택된 세그먼트의 텍스트 커스텀 속성 */
        let selectedAttributes = makeAttributes(color: self.selectedColor, font: self.font)
        
        /* 선택되지 않은 세그먼트의 텍스트 커스텀 속성 */
        let normalAttributes = makeAttributes(color: self.normalColor, font: self.font)
        
        self.setTitleTextAttributes(selectedAttributes, for: .selected)
        self.setTitleTextAttributes(normalAttributes, for: .normal)
        
    }
    
    /// 세그먼트 컨트롤의 배경색을 투명하게 구성합니다.
    private func configureColors(){
        
        self.backgroundColor = .clear
        self.selectedSegmentTintColor = .clear
        
        /* 뒷배경 및 경계선 제거 */
        let clearImage = UIImage()
        self.setBackgroundImage(clearImage, for: .normal, barMetrics: .default)
        self.setBackgroundImage(clearImage, for: .selected, barMetrics: .default)
        self.setDividerImage(clearImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
    }
    
    /// 세그먼트 컨트롤의 텍스트 커스텀 지정
    /// - Parameters:
    ///   - color: 텍스트의 색상 설정
    ///   - font: 텍스트의 폰트 설정
    /// - Returns: 지정한 폰트 스타일 반환
    private func makeAttributes(color: UIColor, font: UIFont) -> [NSAttributedString.Key: Any] {
        
        var value = [NSAttributedString.Key: Any]()
        value[.foregroundColor] = color
        value[.font] = font
        return value
        
    }
    
    /// 외부(뷰 컨트롤러)에서 핸들러 함수 등록
    /// 세그먼트 컨트롤 탭 시 뷰 컨트롤러에서 등록된 핸들러 함수가 실행
    /// - Parameter handler: 핸들러 함수 (뷰 컨트롤러에 정의)
    public func setHandler(_ handler: @escaping (Int) -> Void) {
        self.onSegementChange = handler
    }
    
    
}

// MARK: - Extension
extension CourseSegmentControl {
    
    // MARK: - Indicator Methods
    
    /// 세그먼트 컨트롤 바 추가
    private func selectedSegmentIndicator(){
        
        self.selectedIndicator.backgroundColor = self.selectedColor
        
        self.selectedSegmentIndex = 0
        self.addSubview(self.selectedIndicator)
        
        self.updateIndicatorPosition()
    }
    
    /// 세그먼트 컨트롤 바의 위치 이동
    private func updateIndicatorPosition(){
        
        // 세그먼트 컨트롤의 가로 길이
        let segmentWidth = bounds.width / CGFloat(numberOfSegments)
        
        let leftOffset: CGFloat = 1
        
        // 세그먼트 컨트롤 바의 가로 길이
        let indicatorWidth = maxSegmentLabelWidth + 35

        let indicatorPositionX = segmentWidth * CGFloat(selectedSegmentIndex) + (segmentWidth - indicatorWidth) / 2 - leftOffset
        let indicatorFrame = CGRect(x: indicatorPositionX, y: bounds.height - 4, width: indicatorWidth, height: 4)
        
        UIView.animate(withDuration: 0.25) {
            self.selectedIndicator.frame = indicatorFrame
        }
    }
    
    // MARK: - Handler Methods
    
    /// 세그먼트 컨트롤 탭 시 실행
    @objc public func didTapSegmentControl() {
        self.updateIndicatorPosition()
        self.onSegementChange?(self.selectedSegmentIndex)
    }
    
    
}
