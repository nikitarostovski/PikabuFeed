//
//  PikabuAPIError.swift
//  PikabuFeed
//
//  Created by Nikita Rostovskii on 07.01.2021.
//

import Foundation

enum PikabuAPIError: LocalizedError {
    case requestFailure(message: String)
    case wrongURL
    case responseDataError
    
    var errorDescription: String? {
        switch self {
        case .requestFailure(let message):
            return "Request failed with message: \(message)"
        case .wrongURL:
            return "Error creating url"
        case .responseDataError:
            return "Failed to process response"
        }
    }
}
