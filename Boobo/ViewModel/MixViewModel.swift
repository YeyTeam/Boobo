//
//  MixViewModel.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 22/09/25.
//
import Foundation
import SwiftData

class MixViewModel:ObservableObject{
    var mixManager:MixManager
    var context: ModelContext?
    
    init() {
        self.mixManager = MixManager()
    }
    
    func getAllMixes()->[MixModel]{
        if self.context != nil {
            do{
                let data = try mixManager.fetchData(for : self.context!)
                print("Data fetched successfully \(data.count)")
                return data
            }catch{
                print("Error in fetching : \(error.localizedDescription)")
            }
        }
        return []
    }
}

