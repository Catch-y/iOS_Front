//
//  VoteBarChartViewModel.swift
//  Catchy
//
//  Created by 임소은 on 1/29/25.
//

import SwiftUI
import Combine

class VoteBarChartViewModel: ObservableObject {
    
    // MARK: - Nested Model
    struct VoteOption: Identifiable {
        let id = UUID()
        let name: String // 옵션 이름
        let count: Int   // 투표 수
        let type: CategoryType // CategoryType과 연동

        /// CategoryType의 색상을 반환
        var color: Color {
            return type.setColor()
        }
    }
    
    // MARK: - Properties
    @Published var options: [VoteOption] = [] // 투표 옵션 배열 (초기값은 빈 배열)

    // MARK: - Initializer
    init() {
        loadMockData() // Mock 데이터 로드 (API 호출 대체)
    }

    // MARK: - Methods
    /// Mock 데이터를 로드하는 함수
    func loadMockData() {
        options = [
            VoteOption(name: "카페", count: 3, type: .CAFE),
            VoteOption(name: "주류", count: 2, type: .BAR),
            VoteOption(name: "음식점", count: 5, type: .RESTAURANT),
            VoteOption(name: "체험", count: 1, type: .EXPERIENCE),
            VoteOption(name: "문화생활", count: 4, type: .CULTURELIFE),
            VoteOption(name: "스포츠", count: 2, type: .SPORT),
            VoteOption(name: "휴식", count: 6, type: .REST)
        ]
    }

    /// 서버에서 데이터를 받아오는 함수 (추후 실제 데이터와 연결 예정)
    func fetchDataFromServer() {
        // 서버와 연동 시 데이터를 받아와 `options` 업데이트
        
    }
}

