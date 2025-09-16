//
//  AudioPlayerManager.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 15/09/25.
//
import AVFoundation

class AudioEngineManager:AudioEngineService {
    private var players: [AVAudioPlayerNode] = []

    
    func playSounds(sounds: [String]) throws {
        stopAll()
        
        for sound in sounds {
            guard let url = Bundle.main.url(forResource: sound, withExtension: "mp3") else { continue }
            do {
                let file = try AVAudioFile(forReading: url)
                let playerNode = AVAudioPlayerNode()
                players.append(playerNode)
                
                attachPlayer(node: playerNode, format: file.processingFormat)
                playerNode.scheduleFile(file, at: nil, completionHandler: nil)
            } catch {
                print("Error loading \(sound): \(error)")
            }
        }
        
        do{
            try startEngine()
        }catch{
            throw error
        }
        players.forEach { $0.play() }
    }
    
    func stopAll() {
        players.forEach { $0.stop() }
        players.removeAll()
        stopEngine()
    }
}

