//
//  AudioPlayerManager.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 15/09/25.
//
import Foundation

class AudioPlayerManager:AudioPlayerService {
    
    func playSound(sound : String) throws {
        do {
            guard let url = Bundle.main.url(forResource: sound, withExtension: "mp3") else {
                print("Audio file name not found !")
                throw AudioPlayerError.fileNotFound
            }
            try play(url: url)
        }catch{
            throw AudioPlayerError.audioPlayerFailedToInitialize
        }
    }
    
    override func stop() {
        super.stop()
    }
}
