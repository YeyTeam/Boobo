//
//  AduioPlayerService.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 15/09/25.
//

import AVFoundation

class AudioPlayerService {
    var player: AVAudioPlayer?
    
    func play(url : URL) throws {
        do{
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
        }catch{
            print("Cannot start audio player because of error: \(error)")
            throw error
        }
    }
    
    func stop(){
        player?.stop()
    }
}
