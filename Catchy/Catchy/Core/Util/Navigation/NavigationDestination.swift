//
//  SwiftAPITarget.swift
//  Catchy
//
//  Created by 정의찬 on 1/11/25.
//

import Foundation

enum NavigationDestination: Equatable, Hashable {
    
    case signUpView(signUpNaviData: SignUpNaviData)
    case searchView
    case similarView /* 비슷한 취향을 가진 장소 보기 */
    case courseDetailView(courseId: Int) /* 코스 상세화면 보기 */
    case mypageOption /* 마이페이지 내 옵션 설정 */
    case favoritePlacesView /* 마이페이지 내 선호 장소 */
    case fullScreenMap(viewModel: AppleMapViewModel) // Hashable에서 직접 비교 불가
    
    // Equatable 수동 구현 (fullScreenMap은 비교 제외)
    static func == (lhs: NavigationDestination, rhs: NavigationDestination) -> Bool {
        switch (lhs, rhs) {
        case (.signUpView(let lData), .signUpView(let rData)):
            return lData == rData
        case (.searchView, .searchView),
             (.similarView, .similarView),
             (.mypageOption, .mypageOption),
             (.favoritePlacesView, .favoritePlacesView):
            return true
        case (.courseDetailView(let lId), .courseDetailView(let rId)):
            return lId == rId
        case (.fullScreenMap, .fullScreenMap):
            return false // ✅ `fullScreenMap` 비교하지 않음
        default:
            return false
        }
    }
    
    // Hashable 수동 구현 (`fullScreenMap` 제외)
    func hash(into hasher: inout Hasher) {
        switch self {
        case .signUpView(let data):
            hasher.combine("signUpView")
            hasher.combine(data)
        case .searchView:
            hasher.combine("searchView")
        case .similarView:
            hasher.combine("similarView")
        case .courseDetailView(let courseId):
            hasher.combine("courseDetailView")
            hasher.combine(courseId)
        case .mypageOption:
            hasher.combine("mypageOption")
        case .favoritePlacesView:
            hasher.combine("favoritePlacesView")
        case .fullScreenMap:
            hasher.combine("fullScreenMap")
        }
    }
}
