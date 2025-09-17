//
//  SoundModel.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 14/09/25.
//

import SwiftData
import Foundation

class SoundModel : ObservableObject, Identifiable{
    var name: String
    var url: String
    var icon : String
    @Published var volume : Double = 1
    
    init(name: String, url: String, icon : String,volume : Double = 1.0) {
        self.name = name
        self.url = url
        self.volume = volume
        self.icon = icon
    }
}
