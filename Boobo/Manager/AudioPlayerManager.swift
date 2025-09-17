//
//  AudioPlayerManager.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 15/09/25.
//
import AVFoundation

class AudioPlayerManager : ObservableObject{
    private var audioEngineService: AudioEngineService = AudioEngineService()
    private var players: [AVAudioPlayerNode] = []
    @Published var isPlaying: Bool = false
    var mixers : [String : AVAudioMixerNode] = [:]

    func playSounds(sounds: [SoundModel]) throws {
        stopAll()
        isPlaying = true
        for sound in sounds {
            guard let url = Bundle.main.url(forResource: sound.url, withExtension: "wav") else { continue }
            do {
                let file = try AVAudioFile(forReading: url)
                let playerNode = AVAudioPlayerNode()
                let mixerNode = AVAudioMixerNode() // Mixer khusus untuk player ini
                
                mixers[sound.name] = mixerNode
                
                players.append(playerNode)
                
                // Attach player dan mixer ke engine
                audioEngineService.audioEngine.attach(playerNode)
                audioEngineService.audioEngine.attach(mixerNode)
                
                // Connect player -> mixer -> mainMixer
                audioEngineService.audioEngine.connect(playerNode, to: mixerNode, format: file.processingFormat)
                audioEngineService.audioEngine.connect(mixerNode, to: audioEngineService.audioEngine.mainMixerNode, format: file.processingFormat)

                // Set gain di mixer node
                mixerNode.outputVolume = Float(sound.volume) // gain dalam range 0.0 - 1.0

                // Schedule file untuk player node
                playerNode.scheduleFile(file, at: nil, completionHandler: nil)
                
            } catch {
                print("Error loading \(sound): \(error)")
            }
        }

        
        do{
            try audioEngineService.startEngine()
        }catch{
            throw error
        }
        players.forEach { $0.play() }
    }
    
    func updateVolume(for soundName : String, to newVolume : Float){
        if let mixer = mixers[soundName]{
            mixer.outputVolume = newVolume
        }
    }
    
    
    func stopAll() {
        isPlaying = false
        players.forEach { $0.stop() }
        players.removeAll()
        audioEngineService.stopEngine()
    }
}

