//
//  DropDownTableView.swift
//  Catchy
//
//  Created by LEE on 1/16/25.
//

import UIKit

class DropDownTableView: UITableView {

    // MARK: - Design Properties
    
    private let minHeight: CGFloat = 0
    private let maxHeight: CGFloat = 192
    
    // MARK: - Init
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        rowHeight = 32
        layer.cornerRadius = 4
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.register(DropDownCell.self, forCellReuseIdentifier: DropDownCell.identifier
        )
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        if self.bounds.size != self.intrinsicContentSize {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    // MARK: - Properties 
    override public var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        if contentSize.height > maxHeight {
            return CGSize(width: contentSize.width, height: maxHeight)
        } else if contentSize.height < minHeight {
            return CGSize(width: contentSize.width, height: minHeight)
        } else {
            return contentSize
        }
    }
    

}

// MARK: - Extension
extension DropDownTableView{
    
    /// 테이블 뷰 내의 모든 셀들을 선택되지 않은 상태로 변경
    func deselectAllCell(){
        self.visibleCells.forEach {
            $0.isSelected = false
        }
    }
    
    
    /// 셀이 탭 됐을 때 실행되는 메소드
    /// - Parameter indexPath: 탭한 셀의 인덱스
    func selectRow(at indexPath: IndexPath){
        deselectAllCell()
        
        (self.cellForRow(at: indexPath) as? DropDownCell)?.isSelected = true
    }
}
