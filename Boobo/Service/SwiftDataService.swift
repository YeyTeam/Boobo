//
//  DatabaseService.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 14/09/25.
//

import SwiftData

class SwiftDataService {
    func fetch<T:PersistentModel>(context : ModelContext, for : T) -> [T] {
        let descriptor = FetchDescriptor<T>();
        do{
            let data = try context.fetch(descriptor);
            return data;
        }catch{
            //tobe implemented
            print(error.localizedDescription);
        }
        return [];
    }
    
    func save<T:PersistentModel>(context:ModelContext, _ : T) {
        do{
            try context.save();
        }catch{
            print("Error saving data")
        }
    }
}
