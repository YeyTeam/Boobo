//
//  MotionManager.swift
//  Boobo
//
//  Created by Aditya Rizki on 16/09/25.
//

import SwiftUI
import CoreMotion

// CARA PAKAI DI VIEW = @StateObject private var motion = MotionManager()

class MotionManager: ObservableObject {
    private var motionManager = CMMotionManager()
    @Published var isFaceDown: Bool = false
    
    func start() {
        guard motionManager.isAccelerometerAvailable else { return }
        motionManager.accelerometerUpdateInterval = 1
        motionManager.startAccelerometerUpdates(to: .main) { data, _ in
            guard let accelData = data else { return }
            let z = accelData.acceleration.z
            
            if z > 0.9 {
                self.isFaceDown = true
                print("tengkurap")
            } else {
                self.isFaceDown = false
                print("hp dimainkan")
            }
        }
    }
    
    func stop() {
        motionManager.stopAccelerometerUpdates()
        isFaceDown = false
    }
}
