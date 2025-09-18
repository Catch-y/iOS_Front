//
//  AppFlowEnvrionmentKey.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/18/25.
//

import Foundation
import SwiftUI

class AppFlowEnvrionmentKey: EnvironmentKey {
    static var defaultValue: AppFlow = .init()
}

extension EnvironmentValues {
    var appFlow: AppFlow {
        get { self[AppFlowEnvrionmentKey.self] }
        set { self[AppFlowEnvrionmentKey.self] = newValue }
    }
}
