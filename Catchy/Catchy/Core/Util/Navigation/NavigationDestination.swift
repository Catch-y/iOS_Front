//
//  SwiftAPITarget.swift
//  Catchy
//
//  Created by 정의찬 on 1/11/25.
//

import Foundation
import SwiftUI

enum NavigationDestination: Hashable {
    
    case signUpView(signUpNaviData: SignUpNaviData)
    case searchView
    case similarView /* 비슷한 취향을 가진 장소 보기 */
    case courseDetailView(courseId: Int) /* 코스 상세화면 보기 */
    case mypageOption /* 마이페이지 내 옵션 설정 */
    case favoritePlacesView /* 마이페이지 내 선호 장소 */
    case placeReviewRegsiterView(placeId: Int) /* 장소 리뷰,평점 남기기 */
}
