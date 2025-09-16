//
//  SoundPlay.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 16/09/25.
//

import SwiftUI

struct SoundPlay:View {
    var audioPlayer: AudioPlayerManager = AudioPlayerManager()
    var body: some View {
        VStack{
            PrimaryButton(text : "Play Sound"){
                do {
                    try audioPlayer.playSounds(sounds : ["rain_sound","thunderstorm"])
                }catch{
                    print("Error \(error.localizedDescription)")
                }
            }
        }
        .background(Image("BackgroundA"))
        
    }
}

#Preview {
    SoundPlay()
}
