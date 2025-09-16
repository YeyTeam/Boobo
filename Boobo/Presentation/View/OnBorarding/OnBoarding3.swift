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
            
            Text("Limit the apps that keep you awake, so you can fall asleep more quickly.")
                .foregroundStyle(.white)
                .font(.title.bold())
                .multilineTextAlignment(.center)
                .padding(.vertical, 10)
            
            Text("Tap Open Settings. We suggest you to choose ‘All apps & categories’ to get the best sleep results.")
                .foregroundStyle(.white)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
            
                
            Spacer()
            
            Image("ChooseApp")
                .resizable()
                .frame(height: 120)
                .padding()
            
            Spacer()
            Spacer()
            Spacer()
            
            PrimaryButton(text : "Get Started"){
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
    OnBoardingView()
}
