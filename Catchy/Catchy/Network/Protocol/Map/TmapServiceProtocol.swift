//
//  OSRMServiceProtocol.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/17/25.
//

import Foundation
import Moya
import Combine

protocol TmapServiceProtocol {
    func postTmap(tmap: TMapRouteRequest) ->  AnyPublisher<TMapRouteResponse, MoyaError>
}
