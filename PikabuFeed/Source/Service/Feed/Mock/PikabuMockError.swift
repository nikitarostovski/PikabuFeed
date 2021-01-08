//
//  PikabuMockError.swift
//  PikabuFeed
//
//  Created by Nikita Rostovskii on 07.01.2021.
//

import Foundation

enum PikabuMockError: LocalizedError {
    
    case generalError
    
    var errorDescription: String? {
        switch self {
        case .generalError:
            return "Failed to fetch items"
        }
    }
}
