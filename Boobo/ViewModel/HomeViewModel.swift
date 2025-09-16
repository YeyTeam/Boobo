//
//  HomeViewModel.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 16/09/25.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var selectedTab:Int = 0
    @Published var menuItems:[MenuModel] = [
        MenuModel(title : "Sound", icon : "beats.headphones", value : 0),
        MenuModel(title : "Bedtime", icon : "bed.double.fill" , value : 1),
        MenuModel(title : "Progress", icon : "moon.fill" , value : 2)
    ]
   
    
    func getMenuItems() -> [MenuModel] {
        return self.menuItems
    }
    
    func getContent(index : Int) -> some View {
        switch index {
        case 0:
            return AnyView(SoundPlay())
        case 1:
            return AnyView(BedtimeView())
        default:
            return AnyView(SleepHygieneView())
        }
    }
    
}
