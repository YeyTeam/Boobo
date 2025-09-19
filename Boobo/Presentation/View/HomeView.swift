//
//  HomeView.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 16/09/25.
//

import SwiftUI

struct HomeView: View {
    @State var homeViewModel : HomeViewModel = HomeViewModel()
    var body : some View {
        TabView(selection : $homeViewModel.selectedTab){
            
            ForEach(homeViewModel.getMenuItems(), id : \.self) { menu  in
                Tab(menu.title, systemImage: menu.icon, value : menu.value){
                    homeViewModel.getContent(index: menu.value)
                }
            }
            
        }
        .onAppear(){
            
            if #available(iOS 26.0, *) {
                
            } else {
                let blurEffect = UIBlurEffect(style: .light)
                let appearance = UITabBarAppearance()
                appearance.configureWithTransparentBackground()
                appearance.backgroundEffect = blurEffect
                UITabBar.appearance().tintColor = UIColor.white
                UITabBar.appearance().unselectedItemTintColor = UIColor.white
                UITabBar.appearance().backgroundColor = UIColor.white.withAlphaComponent(0.1)
            }
            
            

        }

    }
}


#Preview {
    var routeManager = RouteManager()
    HomeView()
        .environmentObject(routeManager)
}
