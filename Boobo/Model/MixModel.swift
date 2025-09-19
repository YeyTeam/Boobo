//
//  MixModel.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 14/09/25.
//
import SwiftUI
import SwiftData

@Model
class MixModel {
    var id: UUID = UUID()
    var mixName: String
    @Relationship var mixSounds: [SoundModelBeta] = []
    
    init(mixName: String) {
        self.mixName = mixName
    }
}
