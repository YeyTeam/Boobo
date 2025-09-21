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

    @EnvironmentObject var sessionManager: SessionManager
    @StateObject var audioPlayerManager = AudioPlayerManager()
    @StateObject var motionManager = MotionManager()

    
    var body: some View {
        NavigationStack(path: $router.mainPath) {
            HomeView()
                .navigationDestination(for: MainRouter.self) {
                    route in
                    router.getContent(route: route)
                }
        }
        .onAppear {
            //            let now = Date()
            //            let calendar = Calendar.current
            //            let hour = calendar.component(.hour, from: now)
            //            let minute = calendar.component(.minute, from: now)
            //            let second = calendar.component(.second, from: now)
            //            print("hour \(hour), minute \(minute), second \(second)")
            //
            //            NotificationManager.shared.shceduleNotification(hour : hour, minute: minute, seconds: second + 10, router : router)
            
            router.resetRoot()
            router.navigate(to: .onboarding)
        }
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
    let motionManager : MotionManager = .init()
    let audioPlayerManager : AudioPlayerManager = .init()

    let sessionManager = SessionManager()
//    
    ContentView()
        .environmentObject(router)
        .environmentObject(audioPlayerManager)
        .environmentObject(motionManager)
        .environmentObject(sessionManager)
        
//    //
//    ContentView()
//        .environmentObject(router)
//        .environmentObject(sessionManager)
    

}
