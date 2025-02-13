//
//  SubLocationSelectViewModel.swift
//  Catchy
//
//  Created by 임소은 on 2/12/25.
//

import SwiftUI

class SubLocationSelectViewModel: ObservableObject {
    @Published var selectedSubLocation: String? // 선택된 하위 지역을 저장하는 변수

    let container: DIContainer

    init(container: DIContainer) {
        self.container = container
    }
}
