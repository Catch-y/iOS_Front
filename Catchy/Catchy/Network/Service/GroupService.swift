//
//  GroupRouter.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/17/25.
//

import Foundation
import Moya
import Combine

class GroupService: GroupServiceProtocol, BaseAPIService {
    typealias Target = GroupRouter
    
    var provider: MoyaProvider<Target>
    var decoder: JSONDecoder
    var callbackQueue: DispatchQueue
    
    init(
        provider: MoyaProvider<Target> = APIManager.shared.createProvider(for: Target.self),
        decoder: JSONDecoder = APIManager.shared.sharedDecoder,
        callbackQueue: DispatchQueue = .main
    ) {
        self.provider = provider
        self.decoder = decoder
        self.callbackQueue = callbackQueue
    }
    
    func postGenerate(group: GroupGenerateRequest) -> AnyPublisher<ResponseData<GroupGenerateResponse>, Moya.MoyaError> {
        request(.postGenerate(group: group))
    }
    
    func postJoin(inviteCode: GroupJoinRequest) -> AnyPublisher<ResponseData<GroupJoinResponse>, Moya.MoyaError> {
        request(.postJoin(inviteCode: inviteCode))
    }
    
    func getGroupMember(path: GroupMemberPath) -> AnyPublisher<ResponseData<GroupMemberResponse>, Moya.MoyaError> {
        request(.getGroupMember(path: path))
    }
    
    func getGroupList(query: GroupUserQuery) -> AnyPublisher<ResponseData<GroupUserResponse>, Moya.MoyaError> {
        request(.getGroupList(query: query))
    }
    
    func getInviteGroup(path: GroupInfoPath) -> AnyPublisher<ResponseData<GroupInfoResponse>, Moya.MoyaError> {
        request(.getInviteGroup(path: path))
    }
    
    func deleteGroup(path: GroupDeletePath) -> AnyPublisher<ResponseData<EmptyResponse>, Moya.MoyaError> {
        request(.deleteGroup(path: path))
    }
    
}
