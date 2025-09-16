//
//  ContentView.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 14/09/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var router: RouteManager
//    @EnvironmentObject var sessionManager: SessionManager
    
    var body: some View {
        SoundPlay()
//        NavigationStack(path: $router.mainPath) {
//            OnBoardingView()
//            .navigationDestination(for: MainRouter.self) {
//                route in
//                router.getContent(route: route)
//            }
//        }
    }
}

#Preview {
//    // Buat container khusus preview
//    let config = ModelConfiguration(isStoredInMemoryOnly: true)
//    let container = try! ModelContainer(for: SoundModel.self, configurations: config)
//    
//    // Insert data dummy
//    let context = container.mainContext
//    context.insert(SoundModel(name: "Rain", sound: "rain.WAV"))
//    context.insert(SoundModel(name: "Wind", sound: "wind.WAV"))
//    
//    // Buat instance router & session untuk preview
    let router = RouteManager()
//    let sessionManager = SessionManager()
//    
    ContentView()
        .environmentObject(router)
        
}
