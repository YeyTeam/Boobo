//
//  BooboApp.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 14/09/25.
//

import SwiftUI
import SwiftData

@main
struct BooboApp: App {
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Item.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
    
    static let router = RouteManager()
    @StateObject var sessionManager = SessionManager()
    var audioPlayerManager : AudioPlayerManager = .init()
    var motionManager : MotionManager = .init()
    var durationManager : DurationManager = .init()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Self.router)
                .environmentObject(sessionManager)
                .environmentObject(audioPlayerManager)
                .environmentObject(motionManager)
                .environmentObject(durationManager)
                .modelContainer(for : [
                    MixModel.self
                ])
        }
        //.modelContainer(sharedModelContainer)
    }
}
