//
//  AppAlertEnvironmentKey.swift
//  Catchy
//
//  Created by euijjang97 on 12/8/25.
//

import Foundation
import SwiftUI

struct AppAlertEnvironmentKey: EnvironmentKey {
    static let defaultValue: AppAlert = .init()
}

extension EnvironmentValues {
    var alert: AppAlert {
        get { self[AppAlertEnvironmentKey.self] }
        set { self[AppAlertEnvironmentKey.self] = newValue }
    }
}
