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
            return try self.swiftDataService.fetch(context: context, for : MixModel.self)
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
    
    
}
