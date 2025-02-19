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
    case groupVoteStartView /*  투표 참여 화면 추가 */
    case locationSelectView /*지역 선택 뷰 화면 */
    case createGroupView  /* 그룹 만들기 뷰 */
    case groupVoteView(groupId : Int) /* 그룹 투표시작 페이지*/
   
}
