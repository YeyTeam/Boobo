//
//  OnBoardingView.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 15/09/25.
//

import SwiftUI

struct OnBoardingView: View {
    @StateObject var viewModel: OnBoardingViewModel = OnBoardingViewModel()
    @EnvironmentObject var routeManager:RouteManager
    
    var body: some View {
        VStack{
            AnyView(viewModel.renderBoardingPage(viewModel: viewModel))
        }
        .padding(20)
        .frame(maxHeight : .infinity)
        .onAppear(){
            viewModel.routeManager = routeManager
        }
    }
}

#Preview{
    var RouteManager:RouteManager = RouteManager()
    OnBoardingView()
        .environmentObject(RouteManager)
}
