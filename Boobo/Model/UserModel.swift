//
//  StreakModel.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 14/09/25.
//

import SwiftData
import Foundation

@Model
class UserModel : ObservableObject, Identifiable{
    var streak: Int
    var wakeUpTime: Date
    var sleepTime: Date
    
    init(streak: Int, wakeUpTime: Date) {
        self.streak = streak
        self.wakeUpTime = wakeUpTime
        self.sleepTime = Calendar.current.date(byAdding: .hour, value: -8, to: wakeUpTime) ?? wakeUpTime
    }
    
    func updateTimes(wakeUpTime: Date) {
        self.wakeUpTime = wakeUpTime
        self.sleepTime = Calendar.current.date(byAdding: .hour, value: -8, to: wakeUpTime) ?? wakeUpTime
    }
}
