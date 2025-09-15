//
//  MixManager.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 14/09/25.
//

import SwiftData
import SwiftUI

class MixManager:SwiftDataService{
    
    //Fungsi untuk ambil data mix dari database
    func getAllMix(context : ModelContext) throws -> [MixModel] {
        do{
            return try self.fetch(context: context, for: MixModel.self)
        }catch{
            throw MixError.fetchError
        }
    }
    
    //Fungsi untuk ambil data mix base on id nya
    func getMixById(context : ModelContext, id : UUID) throws -> MixModel? {
        do{
            let data = try self.fetch(context: context, for: MixModel.self).first(where: { $0.id == id})
            if data == nil{
                throw MixError.mixNotFoundError
            }
            return data
        }catch{
            throw MixError.fetchError
        }
    }
    
    //Fungsi untuk mengupdate mix
    func updateMix(context : ModelContext, mixId : UUID, data : MixModel) throws {
        do{
            if let mixData = try self.fetch(context: context, for: MixModel.self).first(where: { $0.id == mixId}){
                mixData.mixName = data.mixName
                try self.save(context: context)
            }else{
                throw MixError.mixNotFoundError
            }
        }catch{
            throw error
        }
    }
    
    func deleteMix(context : ModelContext, mixId : UUID) throws {
        do{
            if let mixData = try self.fetch(context: context, for: MixModel.self).first(where: { $0.id == mixId}){
                context.delete(mixData)
                try self.save(context: context)
            }else{
                throw MixError.mixNotFoundError
            }
        }catch{
            throw error
        }
    }
}
