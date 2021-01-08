//
//  StoryModel.swift
//  PikabuFeed
//
//  Created by Nikita Rostovskii on 07.01.2021.
//

import UIKit

class StoryModel {
    
    var id: Int
    var title: String
    var body: String?
    var images: [String]?
    
    var isFavourite: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "\(id)")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "\(id)")
        }
    }
    
    init(_ model: PikabuStoryAPIModel) {
        self.id = model.id
        self.title = model.title
        self.body = model.body
        self.images = model.images
    }
    
    init(id: Int, title: String, body: String?, images: [String]?) {
        self.id = id
        self.title = title
        self.body = body
        self.images = images
    }
}
