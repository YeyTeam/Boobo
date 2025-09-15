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
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    static let router = Router()
    @StateObject var sessionManager = SessionManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Self.router)
                .environmentObject(sessionManager)
        }
        .modelContainer(sharedModelContainer)
    }
}
