//
//  VisitCheckStrategy.swift
//  Catchy
//
//  Created by Apple Coding machine on 10/18/25.
//

import SwiftUI

/// 방문체크 전략 패턴
struct VisitCheckStrategy: GuideStrategy {
    let sections: [GuideSection] = [
        .init(title: "방문 체크하기 활성화",
              description: """
                방문 장소가 1km 이내에 있을 경우,
                방문 체크 기능을 활성화할 수 있습니다.
                
                해당 장소에 가까이 이동하여 방문 체크를 완료해보세요!
                """
             ),
        .init(title: "방문하기 후 장소 색상",
              description: """
                방문 체크를 완료하면 지도에 표시된 마커 색상이 변경됩니다. 
                변경된 마커는 방문한 지역임을 나타내며,
                탐방 기록을 쉽게 확인할 수 있습니다.
                
                아직 방문하지 않은 지역은 기본 색상으로 표시됩니다.
                방문한 지역을 확인하여 새로운 지역 탐방을 계획해보세요!
                """
             )
    ]
    
    let buttonType: MainBtnType = .check(onOff: .on)
}
