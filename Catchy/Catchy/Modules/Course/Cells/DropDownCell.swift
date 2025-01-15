//
//  DropDownCell.swift
//  Catchy
//
//  Created by LEE on 1/15/25.
//

import UIKit

class DropDownCell: UITableViewCell {

    
    // MARK: - Design Properties
    
    // TODO: - 드랍 다운 메뉴 와이어 프레임 나오면 오토 레이아웃 값 적용
    
    // MARK: - Properties
    static let identifier = "DropDownCell"
    
    // TODO: - 드랍 다운 메뉴 와이어 프레임 나오면 폰트 및 색상 적용
    override var isSelected: Bool{
        didSet{
            // itemLabel.textColor = isSelected ?
        }
    }
    
    // MARK: - UI Components
    private let itemLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        addComponents()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemLabel.text = nil
    }
    
    // MARK: - Add Components & Set Constraints Methods
    private func addComponents(){
        [self.itemLabel].forEach{
            self.addSubview($0)
        }
    }
    
    private func setConstraints(){
        self.itemLabel.snp.makeConstraints { (make) in
            make.leading.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    /// 화면에 셀이 나타나기전 뷰 컨트롤러에서 호출하는 메소드
    /// - Parameter text: Cell에 들어갈 아이템의 텍스트
    public func configure(with text: String){
        itemLabel.text = text
    }
    
}

extension DropDownCell {
    
    
}
