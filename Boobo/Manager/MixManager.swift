//
//  MixManager.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 22/09/25.
//

import SwiftData

class MixManager {
    var swiftDataService : SwiftDataService = .init()
    
    func fetchData(for context : ModelContext) throws-> [MixModel]{
        do{
            return try self.swiftDataService.fetch(context: context, for : MixModel.self).reversed()
        }catch{
            throw MixError.fetchError
        }
    }
    
    func updateMixData(context : ModelContext, data: MixModel, newData: MixModel) throws{
        do{
            data.id = newData.id
            data.mixName = newData.mixName
            data.mixSounds = newData.mixSounds
            try self.swiftDataService.save(context: context);
        }catch{
            throw MixError.fetchError
        }
    }
    
    func insertData(context : ModelContext, data : MixModel) throws {
        do{
            context.insert(data)
            try self.swiftDataService.save(context: context);

        }catch{
            throw MixError.fetchError
        }
    }
    
    func deleteMix(context : ModelContext, data: MixModel) throws{
        do{
            context.delete(data)
            try self.swiftDataService.save(context: context);
        }catch{
            throw MixError.fetchError
        }
    }
    
    
}
