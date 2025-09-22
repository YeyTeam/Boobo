//
//  PlaySoundViewModel.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 19/09/25.
//

import Foundation

class PlaySoundViewModel: ObservableObject {
    var audioPlayerManager : AudioPlayerManager = AudioPlayerManager()
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
}

