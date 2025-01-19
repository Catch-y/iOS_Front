//
//  CourseListCell.swift
//  Catchy
//
//  Created by LEE on 1/16/25.
//

import UIKit

// TODO: - Course List를 받아오는 API가 나오면 모델 작성 후 수정.
class CourseListCell: UITableViewCell {

    static let identifier : String = "CourseListCell"
    
    var categoryTypes : [CategoryType] = []
    
    // MARK: - UIComponents
    
    /// 코스 이미지 뷰
    // TODO: - API 연결 후 작성. 다운 샘플링도 해야함.
    private lazy var courseImageView : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    /// 코스 이름 레이블
    private lazy var courseTitleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.pretend(type: .medium, size: 17)
        return label
    }()
    
    /// 코스의 카테고리 태그
    // TODO: - 4~5개의 카테고리가 있는 경우의 와이어 프레임이 나와야함.
    private lazy var categoryTagView : CategoryTagView = {
        let categoryTagView = CategoryTagView(category: .bar)
        return categoryTagView
    }()
    
    /// 코스의 상세 설명
    private lazy var courseDescription : UILabel = {
        let label = UILabel()
        label.font = UIFont.pretend(type: .light, size: 12)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.addComponents()
        self.setConstraints()
        self.contentView.layer.cornerRadius = 10

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.courseImageView.image = nil
        self.courseTitleLabel.text = nil
        self.courseDescription.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 18, right: 16)
        )
    }
    
    // MARK: - Add Components & Set Constraints Methods
    private func addComponents(){
        
        [
            self.courseImageView,
            self.courseTitleLabel,
            self.categoryTagView,
            self.courseDescription
        ].forEach {
            self.contentView.addSubview($0)
        }
        
    }

    private func setConstraints(){
        
        
        // 코스 사진 레이아웃
        self.courseImageView.snp.makeConstraints { make in
            make.width.equalTo(133)
            make.height.equalTo(116)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
        }
        
        // 코스 이름 레이블 레이아웃
        self.courseTitleLabel.snp.makeConstraints{ make in
            make.left.equalTo(self.courseImageView.snp.right).offset(14)
            make.top.equalToSuperview().offset(26)
        }
        
        // 카테고리 테그 레이아웃
        self.categoryTagView.snp.makeConstraints { make in
            make.top.equalTo(self.courseTitleLabel.snp.bottom).offset(6)
            make.left.equalTo(self.courseTitleLabel.snp.left)
        }
        
        // 코스 상세 설명 레이아웃
        self.courseDescription.snp.makeConstraints { make in
            make.left.equalTo(self.categoryTagView.snp.left)
            make.height.equalTo(36)
            make.width.equalTo(130)
            make.bottom.equalTo(self.courseImageView.snp.bottom).offset(-7)
        }
        
    }
    
    /// 코스 테이블 뷰 셀을 구성하는 메소드
    /// 뷰 컨트롤러에서 호출한다.
    /// - Parameter categoryTypes: 코스가 갖고 있는 카테고리타입
    // TODO: - 코스 모델을 인자로 받아오도록 수정해야함. (API 명세 나오면)
    func configure(with course: Course){
        // self.imageView = ...
        self.courseTitleLabel.text = course.name
        self.courseDescription.text = course.description
        self.categoryTypes = course.categories
    }
}
