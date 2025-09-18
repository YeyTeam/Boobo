//
//  OnBoardingViewModel.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 15/09/25.
//

import SwiftUI

class OnBoardingViewModel : ObservableObject {
    @Published var pageIndex : Int
    @Published var routeManager : RouteManager?
    var notificationManager : NotificationManager?
    
    init() {
        self.pageIndex = 0
        self.routeManager = nil
    }
    
    func renderBoardingPage(viewModel : OnBoardingViewModel) -> any View{
        switch pageIndex {
            case 0:
                return AnyView(OnBoarding1( viewModel: viewModel))
            case 1:
                return AnyView(OnBoarding2( viewModel: viewModel))
            case 2:
                return AnyView(OnBoarding3( viewModel: viewModel))
            case 3:
                return AnyView(OnBoarding4( viewModel: viewModel))
        default:
            return AnyView(EmptyView())
        }
    }
    
    func nextPage(){
        pageIndex += 1
        if pageIndex == 4 {
            self.routeManager?.resetRoot()
        }
       
        pageIndex = max(0, min(pageIndex, 3))
        print("Page Index : \(pageIndex)")
    }
    
    func prevPage(){
        pageIndex -= 1
        pageIndex = max(0, min(pageIndex, 3))
    }
}
