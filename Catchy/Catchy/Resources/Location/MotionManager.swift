//
//  MotionManager.swift
//  Catchy
//
//  Created by 정의찬 on 2/20/25.
//

import Foundation
import CoreMotion

class MotionManager: ObservableObject {
    
    static let shared = MotionManager()
    
    private let motionManager = CMMotionManager()
    
    @Published var isUserMovingSlowly: Bool = false
    
    private var timer: Timer?
    
    private init() {
        startMotionUpdates()
    }
    
    func startMotionUpdates() {
        guard motionManager.isAccelerometerActive else { return }
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.main) { [weak self] data, _ in
            guard let self = self, let acceleration = data?.acceleration else { return }
            
            let threshold: Double = 0.02
            let isMovingSlowly = abs(acceleration.x) < threshold && abs(acceleration.y) < threshold && abs(acceleration.z) < threshold
            
            DispatchQueue.main.async {
                self.isUserMovingSlowly = isMovingSlowly
            }
        }
    }
    
    func stopMotionUpdates() {
            motionManager.stopAccelerometerUpdates()
        }
}
