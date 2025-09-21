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
    @Published var totalStreak: Int
    @Published var isOnProgress: Bool
    
    init() {
        self.isSleepTime = UserDefaults.standard.bool(forKey: "isSleepTime")
        self.isOverlayShow = false
        self.totalStreak = UserDefaults.standard.integer(forKey: "totalStreak")
        self.isOnProgress = UserDefaults.standard.bool(forKey: "isOnProgress")
    }
    
    func setupSleepTime() {
        self.isSleepTime = true
        UserDefaults.standard.set(true, forKey: "isSleepTime")
    }
    
    func setIsOnProgress(state: Bool) {
        if state {
            self.isOnProgress = true
            UserDefaults.standard.set(true, forKey: "isOnProgress")
        } else {
            self.isOnProgress = false
            UserDefaults.standard.set(false, forKey: "isOnProgress")
        }
        
    }
    
    func resetSleepTime() {
        //        self.isSleepTime = false
        //        UserDefaults.standard.set(false, forKey: "isSleepTime")
        
        let now = Date()
        let wakeUpTime = UserDefaults.standard.object(forKey: "wakeUpTime") as? Date
        let sleepTime = UserDefaults.standard.object(forKey: "sleepTime") as? Date
        
        if let wake = wakeUpTime, let _ = sleepTime {
            if now >= wake {
                let calendar = Calendar.current
                let wakeDay = calendar.component(.day, from: wake)
                let nowDay  = calendar.component(.day, from: now)
                
                if nowDay != wakeDay {
                    // Sudah waktunya bangun → reset
                    self.isSleepTime = false
                    UserDefaults.standard.set(false, forKey: "isSleepTime")
                    
                    // Reset setelah jam tidur → streak + 1
                    totalStreak += 1
                    UserDefaults.standard.set(totalStreak, forKey: "totalStreak")
                    print("Streak +1 → total sekarang \(totalStreak)")
                } else {
                    print("Belum ganti hari, tidak hitung streak")
                }
            } else {
                // Belum waktunya bangun → tetap sleep mode
                print("Belum waktunya bangun, tetap sleep mode")
            }
        } else {
            // Fallback: reset saja tanpa streak
            self.isSleepTime = false
            UserDefaults.standard.set(false, forKey: "isSleepTime")
            print("WakeUpTime / SleepTime tidak ditemukan, reset paksa")
        }
    }
}
