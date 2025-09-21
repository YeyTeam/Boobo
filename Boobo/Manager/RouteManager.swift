//
//  Router.swift
//  Boobo
//
//  Created by Aditya Rizki on 15/09/25.
//

import Foundation
import SwiftUI

class RouteManager: ObservableObject {
    @Published var mainPath: [MainRouter] = []
    
    func navigate(to route: MainRouter) {
        mainPath.append(route)
    }
    
    func goBack() {
        if !mainPath.isEmpty {
            mainPath.removeLast()
        }
    }
    
    func getContent(route : MainRouter) -> some View{
        switch route {
        case .home:
            return AnyView(HomeView())
        case .onboarding:
            return AnyView(
                OnBoardingView()
                    .navigationBarBackButtonHidden(true)
            )
        case .setting:
            return AnyView(OnBoardingView())
        case .sleepTime:
            return AnyView(SleepHygieneView())
        case .playSound:
            return AnyView(PlaySoundView())
        }
    }
    
    func resetRoot() {
        mainPath.removeAll()
    }
}
