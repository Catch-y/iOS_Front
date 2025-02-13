//
//  MyGroupsServiceProtocol.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine
import Moya

/// [사용자가 속한 그룹 조회] Service Protocol
protocol MyGroupsServiceProtocol {
    func getMyGroups(myGroupRequest: MyGroupsRequest) -> AnyPublisher<ResponseData<SliceGroupCalendarResponse>, MoyaError>
}
