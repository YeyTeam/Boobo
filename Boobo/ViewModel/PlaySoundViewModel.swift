//
//  PlaySoundViewModel.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 19/09/25.
//

import Foundation

class PlaySoundViewModel: ObservableObject {
    var audioPlayerManager : AudioPlayerManager = .init()
    var sounds: [SoundModel] = [
        soundList[0],
        soundList[1],
        soundList[2],
    ]
    
    func playSound() {
        do {
            try audioPlayerManager.playSounds(sounds: sounds)
        }catch{
            
        }
    }
    
    func stopSound() {
        audioPlayerManager.stopAll()
    }
}

