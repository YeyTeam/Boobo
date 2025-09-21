//
//  SessionManager.swift
//  Boobo
//
//  Created by Aditya Rizki on 15/09/25.
//

import SwiftUI

class SessionManager: ObservableObject {
    @Published var isSleepTime: Bool
    @Published var isOverlayShow: Bool
    
    init() {
        self.isSleepTime = false
        self.isOverlayShow = false
        UserDefaults.standard.bool(forKey: "isSleepTime")
    }
    
    func setupSleepTime() {
        self.isSleepTime = true
        UserDefaults.standard.set(true, forKey: "isSleepTime")
    }
    
    func resetSleepTime() {
        self.isSleepTime = false
        UserDefaults.standard.set(false, forKey: "isSleepTime")
    }
}
