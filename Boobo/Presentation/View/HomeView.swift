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
            let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
            let blurBackground = UIVisualEffectView(effect: blurEffect)

            UITabBar.appearance().standardAppearance.backgroundEffect = blurBackground.effect as? UIBlurEffect
            UITabBar.appearance().barTintColor = UIColor.white
            UITabBar.appearance().unselectedItemTintColor = UIColor.black
            UITabBar.appearance().backgroundColor = UIColor.white.withAlphaComponent(0.2)
            
        }

    }
}


#Preview {
    HomeView()
}
