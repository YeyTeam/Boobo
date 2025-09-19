//
//  OnBoarding1.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 15/09/25.
//


import SwiftUI

struct OnBoarding3:View {
    var viewModel:OnBoardingViewModel?
    
    var body: some View {
        VStack{
            
            Text("Get Notified!.")
                .foregroundStyle(.white)
                .font(.title.bold())
                .multilineTextAlignment(.center)
                .padding(.vertical, 10)
            
            Text("Better sleep starts with routine. We’ll remind you before bedtime to play your sounds, helping you unwind and fall asleep faster.")
                .foregroundStyle(.white)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
            
                
            Spacer()
            
            Image("Notification")
                .resizable()
                .frame(width : 180, height: 180)
                .padding()
            
            Spacer()
            
            PrimaryButton(text : "Get Started"){
                NotificationManager.shared.requestPermission()

                viewModel?.nextPage()
            }
            
            Button(
                action: {
                    
                }
            ){
                Text("Skip")
                    .foregroundColor(.white)
            }
        }
        .background(
            Image("BackgroundB")
        )
        
    }
}

#Preview{
    var routeManager: RouteManager = .init()
    OnBoardingView()
        .environmentObject(routeManager)
}
