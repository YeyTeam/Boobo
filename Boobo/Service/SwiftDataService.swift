//
//  DatabaseService.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 14/09/25.
//

import SwiftData

class SwiftDataService {
    func fetch<T:PersistentModel>(context : ModelContext, for : T.Type) throws -> [T] {
        let descriptor = FetchDescriptor<T>();
        do{
            let data = try context.fetch(descriptor);
            return data;
        }catch{
            //tobe implemented
            print(error.localizedDescription);
            throw error;
        }
    }
    
    func save(context:ModelContext) throws {
        do{
            try context.save();
        }catch{
            print("Error saving data")
            throw error
        }
    }
}
