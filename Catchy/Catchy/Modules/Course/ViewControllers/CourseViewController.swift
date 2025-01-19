//
//  CourseViewController.swift
//  Catchy
//
//  Created by LEE on 1/14/25.
//

import UIKit
import SwiftUI

class CourseViewController: UIViewController {
    

    // MARK: - Properties
    /// 코스 DIY = 0
    /// AI 추천 = 1
    private var selectedTapIndex = 0
    
    /// 코스 데이터를 담는 배열
    private var courses: [Course] = []
    
    
    // MARK: - UIComponents Properties
    /// 코스 탭 바 터치 시 나타나는 메인 화면
    private lazy var courseView: CourseView = {
        let courseView = CourseView()
        return courseView
    }()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.courseView
        
        // 핸들러 함수 등록
        self.courseView.segmentControl.setHandler { [weak self] index in
            self?.handleSegmentChange(at: index)
        }
        
        // Delegete 설정
        self.courseView.collectionView.delegate = self
        self.courseView.collectionView.dataSource = self
        self.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
    }
    
    
    // MARK: - Handler Methods
    private func handleSegmentChange(at index: Int) {
        selectedTapIndex = index
        
    }
    
    // TODO: - API 연결 전, 더미데이터로 구현.
    private func loadData(){
        
        // 코스 DIY 데이터를 받아옴
        if selectedTapIndex == 0 {
            
        
        // AI 추천 데이터를 받아옴
        }else {
            
        }
        
        self.courses = dummyCourses
        self.courseView.collectionView.reloadData()
        
    }

}

// MARK: - Extension
extension CourseViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.courses.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CourseListCell.identifier, for: indexPath) as? CourseListCell else {
            return UICollectionViewCell()
        }
        
        let course = courses[indexPath.item]
        cell.configure(with: course)
        
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// TODO: - API 명세에 맞게 Course 모델 설계.
// 현재는 더미데이터.
struct Course: Codable {
    let name: String
    let description: String
    let categories: [CategoryType]
}

let dummyCourses: [Course] = [
    Course(name: "서울 카페 투어", description: "서울의 유명한 카페를 둘러보는 코스입니다.", categories: [.cafe, .culturalLife]),
    Course(name: "한강 자전거 라이딩", description: "한강을 따라 자전거를 타며 경치를 즐기는 코스입니다.", categories: [.sport, .rest]),
    Course(name: "홍대 맛집 탐방", description: "홍대의 인기 맛집을 방문하는 코스입니다.", categories: [.restaurant, .cafe]),
    Course(name: "전통주 체험", description: "한국 전통주를 맛보고 체험하는 코스입니다.", categories: [.bar, .experience]),
    Course(name: "남산 등산", description: "남산을 등산하며 자연을 느끼는 코스입니다.", categories: [.sport, .rest]),
    Course(name: "인사동 문화 산책", description: "인사동의 전통 문화와 예술을 감상하는 코스입니다.", categories: [.culturalLife, .experience]),
    Course(name: "강릉 해변 여행", description: "강릉의 아름다운 해변을 즐기는 코스입니다.", categories: [.rest, .cafe]),
    Course(name: "부산 야경 투어", description: "부산의 아름다운 야경을 감상하는 코스입니다.", categories: [.culturalLife, .bar]),
    Course(name: "제주도 올레길 걷기", description: "제주도의 올레길을 걸으며 자연을 만끽하는 코스입니다.", categories: [.sport, .rest]),
    Course(name: "경복궁 역사 탐방", description: "경복궁을 방문하여 한국의 역사를 배우는 코스입니다.", categories: [.culturalLife, .experience]),
    Course(name: "서울 야시장 투어", description: "서울의 다양한 야시장을 둘러보는 코스입니다.", categories: [.restaurant, .culturalLife]),
    Course(name: "한옥 마을 체험", description: "전통 한옥에서의 생활을 체험하는 코스입니다.", categories: [.experience, .rest]),
    Course(name: "강원도 스키 여행", description: "강원도의 스키장에서 스키를 즐기는 코스입니다.", categories: [.sport, .rest]),
    Course(name: "부산 해산물 맛보기", description: "부산의 신선한 해산물을 맛보는 코스입니다.", categories: [.restaurant, .cafe]),
    Course(name: "서울 박물관 투어", description: "서울의 주요 박물관을 방문하는 코스입니다.", categories: [.culturalLife, .experience]),
    Course(name: "전주 한옥마을 여행", description: "전주의 한옥마을을 둘러보는 코스입니다.", categories: [.culturalLife, .rest]),
    Course(name: "속초 등대 해안 산책", description: "속초의 등대와 해안을 따라 걷는 코스입니다.", categories: [.rest, .cafe]),
    Course(name: "대구 먹거리 투어", description: "대구의 유명한 먹거리를 탐방하는 코스입니다.", categories: [.restaurant, .bar]),
    Course(name: "광주 예술 거리 산책", description: "광주의 예술 거리를 둘러보는 코스입니다.", categories: [.culturalLife, .experience]),
    Course(name: "울산 바다 낚시 체험", description: "울산에서 바다 낚시를 체험하는 코스입니다.", categories: [.experience, .rest])
]


#Preview {
    CourseViewController()
}
