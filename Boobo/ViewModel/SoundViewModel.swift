//
//  SoundViewModel.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 17/09/25.
//

import Foundation
import SwiftUI

class SoundViewModel:ObservableObject {
    @ObservedObject var audioPlayerManager:AudioPlayerManager
    @Published var isPlaying:Bool = false
    @Published var sounds:[SoundModel] = []
    
    init() {
        self.audioPlayerManager = AudioPlayerManager()
        self.sounds = [
//            SoundModel(name : "Bird", url : "bird_sound", icon : "bird.fill", volume : 0.5),
//            SoundModel(name : "Rain", url : "rain_sound", icon : "cloud.rain.fill",volume : 0.5),
//            SoundModel(name : "Forest", url : "forest_sound", icon : "tree.fill",volume : 0.5)
        ]
    }
    
    func updateVolume(index:Int, volume:Float){
        self.sounds[index].volume = Double(volume)
        self.audioPlayerManager.updateVolume(for: self.sounds[index].name, to: volume)
    }
    
    func playSound(){
        if self.sounds.isEmpty{
            return
        }
        if !audioPlayerManager.isPlaying{
            do{
                try  self.audioPlayerManager.playSounds(sounds : self.sounds)
            }catch{
                print(error.localizedDescription)
            }
        }else{
            self.audioPlayerManager.stopAll()
        }
        isPlaying = self.audioPlayerManager.isPlaying

    }
    
    func play(){
        if self.audioPlayerManager.isPlaying{
            do{
                self.audioPlayerManager.stopAll()
                try  self.audioPlayerManager.playSounds(sounds : self.sounds)
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func addSound(_ sound:SoundModel) -> Bool{
        if let index = self.sounds.firstIndex(where: { $0.name == sound.name }) {
            self.sounds.remove(at: index)
            self.play()
            return false
        } else {
        }

        if self.sounds.count < 3{
            self.sounds.append(sound)
            self.play()
            return true
        }
        return false
    }
    
    func removeSound(_ sound:SoundModel){
        var i = 0
        for sound in self.sounds{
            if sound.name == sound.name{
               break
            }
            i+=1
        }
        self.sounds.remove(at:i )
    }
    
    func addMixSound(name: String) {
        print("addMixSound = \(name)")
        
        for sound in sounds {
            print("Name: \(sound.name), url: \(sound.url), icon: \(sound.icon)")
        }
    }
    
}
