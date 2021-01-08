//
//  FeedListDisplayMode.swift
//  PikabuFeed
//
//  Created by Nikita Rostovskii on 07.01.2021.
//

import Foundation

enum FeedListDisplayMode {
    case all
    case favourites
    
    var title: String {
        switch self {
        case .all:
            return "Лента"
        case .favourites:
            return "Избранные"
        }
    }
    
    var iconName: String {
        switch self {
        case .all:
            return "icList"
        case .favourites:
            return "icHeartOutlined"
        }
    }
}
