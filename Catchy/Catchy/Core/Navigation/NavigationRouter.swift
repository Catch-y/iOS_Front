//
//  NavigationRouter.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/18/25.
//

import Foundation
import Combine

protocol NavigationRoutable {
    var destination: [NavigationDestination] { get set }
    func push(to view: NavigationDestination)
    func pop()
    func popToRootView()
}

@Observable
class NavigationRouter: NavigationRoutable {
    var destination: [NavigationDestination] = .init()
    
    func push(to view: NavigationDestination) {
        destination.append(view)
    }
    
    func pop() {
        _ = destination.popLast()
    }
    
    func popToRootView() {
        destination.removeAll()
    }
}
