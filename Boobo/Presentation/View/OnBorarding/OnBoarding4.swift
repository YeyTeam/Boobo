//
//  OnBoarding1.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 15/09/25.
//


import SwiftUI

struct OnBoarding4:View {
    var viewModel : OnBoardingViewModel?
    var body: some View {
        VStack{
            
            Text("You're All Set")
                .foregroundStyle(.white)
                .font(.title.bold())
                .multilineTextAlignment(.center)
                .padding(.vertical, 10)
            
            Text("You’re ready to begin building better sleep habits.")
                .foregroundStyle(.white)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
            
                
            Spacer()
            
            Image("Sleep")
                .resizable()
                .frame(width : 180, height: 200)
                .padding()
            
            Spacer()
            
            PrimaryButton(text : "Done"){
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
