//
//  AudioPlayerError.swift
//  Boobo
//
//  Created by Muhammad Chandra Ramadhan on 15/09/25.
//
import Foundation

enum AudioPlayerError:LocalizedError {
    case fileNotFound
    case audioPlayerFailedToInitialize
    case audioPlayerFailedToStart
    case audioPlayerFailedToStop
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "File not found"
        case .audioPlayerFailedToInitialize:
            return "Fail to initialize audio player"
        case .audioPlayerFailedToStart:
            return "Fail to start audio player"
        case .audioPlayerFailedToStop:
            return "Fail to stop audio player"
        }
    }
}
