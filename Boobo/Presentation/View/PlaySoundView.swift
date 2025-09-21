//
//  PlaySoundView.swift
//  Boobo
//
//  Created by Aditya Rizki on 21/09/25.
//

import SwiftUI

struct PlaySoundView: View {
    @EnvironmentObject var router: RouteManager
    @EnvironmentObject var sessionManager: SessionManager
    @StateObject var audioPlayerManager = AudioPlayerManager()
    @StateObject var motionManager = MotionManager()
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    sessionManager.setIsOnProgress(state: false)
                    router.navigate(to: .home)
                }) {
                    Text("Close")
                }
                Button(action: {
                    
                }) {
                    Text("Play")
                }
            }
            
            // Overlay Face Down Phone
            if sessionManager.isOverlayShow {
                PhoneFaceDownOverlay()
                    .zIndex(999)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if sessionManager.isSleepTime {
                motionManager.start()
            }
        }
        .onDisappear {
            motionManager.stop()
            motionManager.stop()
        }
        // Mulai / stop sensor saat sleep session dimulai
        .onChange(of: sessionManager.isSleepTime) {
            if sessionManager.isSleepTime {
                motionManager.start()
            } else {
                motionManager.stop()
                audioPlayerManager.stopAll() // stop sound kalau bukan sleep time
            }
        }
        // Play sound otomatis ketika face down
        .onChange(of: motionManager.isFaceDown) {
            if sessionManager.isSleepTime && motionManager.isFaceDown {
                audioPlayerManager.playDefault()
                sessionManager.isOverlayShow = false
            } else {
                audioPlayerManager.stopAll()
            }
        }
        // Finish condition
        .onChange(of: scenePhase) {
            switch scenePhase {
            case .active:
                print("App jadi aktif lagi (HP baru dibuka / kembali ke foreground)")
                sessionManager.resetSleepTime()
            case .background:
                print("in background phase")
            case .inactive:
                print("in active phase")
            @unknown default: break
            }
        }
    }
    
    func playSound(){
        if !audioPlayerManager.isPlaying{
            do{
                try  self.audioPlayerManager.playSounds(sounds : [SoundModel(name : "Rain", url : "rain_sound", icon : "cloud.rain.fill",volume : 0.5)])
            }catch{
                print(error.localizedDescription)
            }
        }else{
            self.audioPlayerManager.stopAll()
        }
    }
}

#Preview {
    let router = RouteManager()
    let sessionManager = SessionManager()
    
    PlaySoundView()
        .environmentObject(router)
        .environmentObject(sessionManager)
}
