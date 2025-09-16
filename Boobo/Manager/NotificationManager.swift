//
//  NotificationManager.swift
//  Boobo
//
//  Created by Aditya Rizki on 16/09/25.
//

import SwiftUI
import UserNotifications

class NotificationManager: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationManager()
    weak var router: RouteManager?
    
    private override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    // Minta izin
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            print("Granted:", granted, "Error:", error?.localizedDescription ?? "-")
        }
    }
    
    // Jadwalkan notifikasi jam 22:00 setiap hari
    func scheduleDailyAt10PM() {
        var dc = DateComponents()
        dc.hour = 22
        dc.minute = 0
        dc.second = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dc, repeats: true)
        
        let content = UNMutableNotificationContent()
        content.title = "Waktu Tenang"
        content.body = "Waktunya tidur 🛌"
        
        let req = UNNotificationRequest(identifier: "daily-22", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(req)
    }
    
    // Saat notif muncul (foreground)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
    
    // Saat notif ditekan
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        DispatchQueue.main.async {
            self.router?.navigate(to: .sleepTime)
        }
        completionHandler()
    }
}
