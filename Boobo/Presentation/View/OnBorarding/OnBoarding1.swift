//
//  OnBoarding1.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 15/09/25.
//


import SwiftUI

struct OnBoarding1:View {
    var viewModel: OnBoardingViewModel?
    
    var body: some View {
        VStack{
            Spacer()
            
            Image("PersonSleep")
                .resizable()
                .frame(width : 165, height: 250)
            
            Text("Because great nights, lead to great days")
                .foregroundStyle(.white)
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding()
                .padding(.horizontal, 30)
            
            Spacer()
            
            PrimaryButton(text : "Get Started"){
                viewModel?.nextPage()

            }
        }
        .background(
            Image("BackgroundA")
        )
        
    }
}

#Preview{
    let routeManager = RouteManager()
    
    OnBoardingView()
        .environmentObject(routeManager)
}
