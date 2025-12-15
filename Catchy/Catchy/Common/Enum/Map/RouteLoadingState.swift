//
//  RouteLoadingState.swift
//  Catchy
//
//  Created by euijjang97 on 12/15/25.
//

import Foundation

enum RouteLoadingState: Equatable {
    case idle
    case loading
    case loaded
    case failed(String)
}
