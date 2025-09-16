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
        case .onboarding:
            return OnBoardingView()
        case .setting:
            return OnBoardingView()
        case .sleepTime:
            return OnBoardingView()
        }
    }
    
    func resetRoot() {
        mainPath.removeAll()
    }
}
