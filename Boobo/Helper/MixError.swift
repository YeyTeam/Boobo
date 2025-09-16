//
//  MixError.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 14/09/25.
//

import Foundation

enum MixError: LocalizedError {
    case fetchError
    case mixNotFoundError
    
    var localizedDescription: String {
        switch self {
        case .fetchError:
            return "Cannot get data from server !"
        case .mixNotFoundError:
            return "Mix not found !"
        }
        
    }
}
