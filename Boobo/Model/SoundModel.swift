//
//  SoundModel.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 14/09/25.
//

import SwiftData

@Model
class SoundModel {
    var name: String
    var sound: String
    
    init(name: String, sound: String) {
        self.name = name
        self.sound = sound
    }
}
