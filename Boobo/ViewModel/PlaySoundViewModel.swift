//
//  PlaySoundViewModel.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 19/09/25.
//

import Foundation
import SwiftData

class PlaySoundViewModel: ObservableObject {
    var audioPlayerManager : AudioPlayerManager = AudioPlayerManager()
    var mixManager: MixManager = MixManager()
    @Published var currentMix:MixModel = MixModel(mixName: "My Mix", mixSounds: [])
    
    var sounds: [SoundModel] = [
        soundList[0],
        soundList[1],
        soundList[2],
    ]
    
    func playSound() {
        do {
            try audioPlayerManager.playSounds(sounds: self.sounds)
            print("Success playing sound")
        }catch{
            print("Error playing sound \(error.localizedDescription)")
        }
    }
    
    func stopSound() {
        audioPlayerManager.stopAll()
    }
    
    func loadMix(context : ModelContext){
        do{
            if let mix = try mixManager.fetchData(for: context).first(where: { $0.id == UUID( uuidString : UserDefaults.standard.string(forKey: "currentMixID") ?? "") }){
                print(mix.mixName)
                self.currentMix = mix
            }
        }catch{
            print("Error getting mix data")
        }
    }
}

