//
//  ContentView.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 14/09/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var sessionManager: SessionManager
    
    var body: some View {
        NavigationStack(path: $router.mainPath) {
            VStack {
                Text("content view")
            }
            .navigationDestination(for: MainRouter.self) {
                route in
                switch route {
                case .onboarding:
                    Text("Onboarding")
                case .setting:
                    Text("Setting")
                case .sleepTime:
                    Text("Sleep Hygiene")
                }
            }
        }
    }
}

#Preview {
    // Buat container khusus preview
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: SoundModel.self, configurations: config)
    
    // Insert data dummy
    let context = container.mainContext
    context.insert(SoundModel(name: "Rain", sound: "rain.WAV"))
    context.insert(SoundModel(name: "Wind", sound: "wind.WAV"))
    
    // Buat instance router & session untuk preview
    let router = Router()
    let sessionManager = SessionManager()
    
    return ContentView()
        .environmentObject(router)
        .environmentObject(sessionManager)
        .modelContainer(container)
}
