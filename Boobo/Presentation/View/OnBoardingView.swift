//
//  OnBoardingView.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 15/09/25.
//

import SwiftUI

struct OnBoardingView: View {
    let viewModel: OnBoardingViewModel = OnBoardingViewModel()
    
    var body: some View {
        VStack{
            AnyView(viewModel.renderBoardingPage())
            
        }
        .padding(20)
        .frame(maxHeight : .infinity)
    }
}

#Preview{
    OnBoardingView()
}
