//
//  MyGroupsRepository.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine

/// [사용자가 속한 그룹 조회] Repository
class MyGroupsRepository: MyGroupsRepositoryProtocol {
    private let service: MyGroupsServiceProtocol
    
    init(service: MyGroupsServiceProtocol = MyGroupsService()) {
        self.service = service
    }
    
    func getMyGroups(myGroupRequest: MyGroupsRequest) -> AnyPublisher<ResponseData<SliceGroupCalendarResponse>, Error> {
        return service.getMyGroups(myGroupRequest: myGroupRequest)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
