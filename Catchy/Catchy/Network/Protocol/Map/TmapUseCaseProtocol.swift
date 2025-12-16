//
//  OSRMUseCaseProtocol.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/17/25.
//

import Foundation
import Moya
import Combine

protocol TmapUseCaseProtocol {
    func executePostTmap(tmap: TMapRouteRequest) ->  AnyPublisher<TMapRouteResponse, MoyaError>
}
