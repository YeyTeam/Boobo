//
//  AudioPlayerManager.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 15/09/25.
//
import Foundation

class AudioPlayerManager  {
    var audioPlayer : [AudioPlayerService]
    
    init() {
        self.audioPlayer = []
    }
    
    func playSound(sound : String) throws {
        do {
            guard let url = Bundle.main.url(forResource: sound, withExtension: "mp3") else {
                print("Audio file name not found !")
                throw AudioPlayerError.fileNotFound
            }
            audioPlayer.append(AudioPlayerService())
            try audioPlayer[0].play(url: url)
        }catch{
            throw AudioPlayerError.audioPlayerFailedToInitialize
        }
    }
    
    
}
