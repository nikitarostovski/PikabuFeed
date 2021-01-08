//
//  StoryTableViewCellModel.swift
//  PikabuFeed
//
//  Created by Nikita Rostovskii on 07.01.2021.
//

import UIKit

class StoryTableViewCellModel: BaseTableViewCellModel {
    
    public let title: String
    public let body: String?
    public let imageURL: String?
    
    public var favouriteTapAction: ((_ newValue: Bool) -> Void)?
    public var isFavourite: Bool
    
    public override var cellIdentifier: String {
        StoryTableViewCell.cellIdentifier
    }
    
    public init(title: String, body: String?, imageURL: String?, isFavourite: Bool = false) {
        self.isFavourite = isFavourite
        self.title = title
        self.body = body
        self.imageURL = imageURL
    }
}
