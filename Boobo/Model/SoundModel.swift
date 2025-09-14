//
//  SoundModel.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 14/09/25.
//

import Foundation

class SoundModel {
    var name: String
    var sound: URL
    
    init(name: String, sound: URL) {
        self.name = name
        self.sound = sound
    }
}
