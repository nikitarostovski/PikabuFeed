//
//  ImageContainerTableViewCellModel.swift
//  PikabuFeed
//
//  Created by Nikita Rostovskii on 07.01.2021.
//

import Foundation

class ImageContainerTableViewCellModel: BaseTableViewCellModel {
    
    public let images: [String]
    
    public override var cellIdentifier: String {
        ImageContainerTableViewCell.cellIdentifier
    }
    
    public init(images: [String]) {
        self.images = images
    }
}
