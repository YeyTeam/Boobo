//
//  OnBoarding1.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 15/09/25.
//


import SwiftUI

struct OnBoarding2:View {
    var viewModel: OnBoardingViewModel?
    @State var selectedTime: Date = Date()
    @EnvironmentObject var routeManager: RouteManager
    
    var body: some View {
        VStack{
            
            Text("Your wake up time")
                .foregroundStyle(.white)
                .font(.title.bold())
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .padding(.vertical, 10)
            
            Text("Your wake-up time helps us suggest the best bedtime for better rest.")
                .foregroundStyle(.white)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
            
            Spacer()
            Spacer()
            
            //TimePicker()
            DatePicker("Pilih Jam", selection: $selectedTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
                .labelsHidden()
                .colorScheme(.dark)
            
        
            Spacer()
            Spacer()
            
            PrimaryButton(text : "Get Started"){
                // Hitung sleep time (8 jam sebelum bangun)
                let sleepTime = selectedTime.addingTimeInterval(-8 * 60 * 60)
                
                // Simpan ke UserDefaults
                UserDefaults.standard.set(selectedTime, forKey: "wakeUpTime")
                UserDefaults.standard.set(sleepTime, forKey: "sleepTime")
                
                let components = Calendar.current.dateComponents([.hour, .minute, .second], from: sleepTime)
                
                NotificationManager.shared.scheduleDaily(hour: components.hour ?? 22, minute: components.minute ?? 0, second: components.second ?? 0, router: routeManager)
                
                print("Notifikasi will apear on : \(components.hour ?? 0) : \(components.minute ?? 0) : \(components.second ?? 0)")
                
                viewModel?.nextPage()
            }
        }
        .background(
            Image("BackgroundB")
        )
        
    }
}

#Preview{
    let routeManager: RouteManager = .init()
    OnBoardingView()
        .environmentObject(routeManager)
}
