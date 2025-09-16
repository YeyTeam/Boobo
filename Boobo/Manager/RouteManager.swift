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
    
    func goBack<T: Hashable>(path: Binding<[T]>) {
        if !path.isEmpty {
            path.wrappedValue.removeLast()
        }
    }
    
    func getContent(route : MainRouter) -> some View{
        switch route {
        case .onboarding:
            return AnyView(OnBoardingView())
        case .setting:
            return AnyView(OnBoardingView())
        case .sleepTime:
            return AnyView(OnBoardingView())
        case .home:
            return AnyView(SoundPlay())
        }
    }
    
    func resetRoot<T: Hashable>(path: Binding<[T]>) {
        path.wrappedValue.removeAll()
    }
}
