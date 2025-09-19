//
//  SoundModelBeta.swift
//  Boobo
//
//  Created by Aditya Rizki on 19/09/25.
//

import SwiftData
import Foundation

@Model
class SoundModelBeta : ObservableObject, Identifiable{
    var name: String
    var url: String
    var icon : String
    var volume: Double
    
    init(name: String, url: String, icon : String, volume: Double) {
        self.name = name
        self.url = url
        self.icon = icon
        self.volume = volume
    }
}
