//
//  MyGroupsService.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [사용자가 속한 그룹 조회] Service
class MyGroupsService: MyGroupsServiceProtocol {
    private let provider: MoyaProvider<MyGroupsAPITarget>
    
    init(provider: MoyaProvider<MyGroupsAPITarget> = MoyaProvider<MyGroupsAPITarget>()) {
        self.provider = provider
    }
    
    func getMyGroups(myGroupRequest: MyGroupsRequest) -> AnyPublisher<ResponseData<SliceGroupCalendarResponse>, MoyaError> {
        return provider.requestPublisher(.getMyGroups(myGroupRequest: myGroupRequest))
            .map(ResponseData<SliceGroupCalendarResponse>.self)
            .eraseToAnyPublisher()
    }
}
