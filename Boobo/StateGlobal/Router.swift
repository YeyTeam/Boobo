//
//  Router.swift
//  Boobo
//
//  Created by Aditya Rizki on 15/09/25.
//

import Foundation
import SwiftUI

enum MainRouter: Hashable, Equatable {
    case onboarding
    case setting
    case sleepTime
}

class Router: ObservableObject {
    @Published var mainPath: [MainRouter] = []
    
    func navigate(to route: MainRouter) {
        mainPath.append(route)
    }
    
    func goBack<T: Hashable>(path: Binding<[T]>) {
        if !path.isEmpty {
            path.wrappedValue.removeLast()
        }
    }
    
    func resetRoot<T: Hashable>(path: Binding<[T]>) {
        path.wrappedValue.removeAll()
    }
}
