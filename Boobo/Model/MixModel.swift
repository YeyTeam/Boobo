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
    var id:UUID
    var mixName:String
    
    init(id: UUID, mixName: String) {
        self.id = UUID()
        self.mixName = mixName
    }
}
