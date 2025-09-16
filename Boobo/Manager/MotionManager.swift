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
    
    init() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 1
            motionManager.startAccelerometerUpdates(to: .main) { data, error in
                guard let accelData = data else { return }
                let z = accelData.acceleration.z
                
                if z > 0.9 {
                    self.isFaceDown = true
                    print("tengkurap")
                } else {
                    // posisi miring, anggap bukan tengkurap
                    self.isFaceDown = false
                    print("hp dimainkan")
                }
            }
        }
    }
}
