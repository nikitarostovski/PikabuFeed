//
//  PikabuStoryModel.swift
//  PikabuFeed
//
//  Created by Nikita Rostovskii on 07.01.2021.
//

import Foundation

struct PikabuStoryAPIModel: Codable {
    
    var id: Int
    var title: String
    var body: String?
    var images: [String]?
}
