//
//  AudioEngineService.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 16/09/25.
//

import AVFoundation

class AudioEngineService{
    var audioEngine = AVAudioEngine()
    
    func attachPlayer(node : AVAudioPlayerNode, format : AVAudioFormat ){
        audioEngine.attach(node)
        audioEngine.connect(node, to: audioEngine.mainMixerNode, format : format)
    }
    
    func startEngine() throws{
        do{
            try audioEngine.start()
        }catch{
            throw error
        }
    }
    
    func stopEngine(){
        audioEngine.stop()
    }
}
