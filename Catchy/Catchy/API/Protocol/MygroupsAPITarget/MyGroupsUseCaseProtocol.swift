//
//  MyGroupsUseCaseProtocol.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine

/// [사용자가 속한 그룹 조회] UseCase Protocol
protocol MyGroupsUseCaseProtocol {
    func executeGetMyGroups(myGroupRequest: MyGroupsRequest) -> AnyPublisher<ResponseData<SliceGroupCalendarResponse>, Error>
}
