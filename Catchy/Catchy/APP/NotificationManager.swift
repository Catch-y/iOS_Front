//
//  NotificationManager.swift
//  Catchy
//
//  Created by 정의찬 on 2/10/25.
//

import Foundation

class NotificationManager: ObservableObject {
    @Published var deviceToken: String = ""
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateDeviceToken), name: .deviceTokenReceived, object: nil)
    }
    
    @objc private func updateDeviceToken(_ notification: Notification) {
        if let token = notification.object as? String {
            DispatchQueue.main.async {
                self.deviceToken = token
            }
        }
    }
}
