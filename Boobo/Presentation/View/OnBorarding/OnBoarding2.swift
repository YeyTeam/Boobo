//
//  OnBoarding1.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 15/09/25.
//


import SwiftUI

struct OnBoarding2:View {
    var viewModel: OnBoardingViewModel?
    
    var body: some View {
        VStack{
            Spacer()
            
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
            
            TimePicker()
            
            Spacer()
            Spacer()
            
            PrimaryButton(text : "Get Started"){
                viewModel?.nextPage()
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
