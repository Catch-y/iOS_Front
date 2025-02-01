//
//  MyGroupsRepositoryProtocol.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine

/// [사용자가 속한 그룹 조회] Repository Protocol
protocol MyGroupsRepositoryProtocol {
    func getMyGroups(myGroupRequest: MyGroupsRequest) -> AnyPublisher<ResponseData<SliceGroupCalendarResponse>, Error>
}
