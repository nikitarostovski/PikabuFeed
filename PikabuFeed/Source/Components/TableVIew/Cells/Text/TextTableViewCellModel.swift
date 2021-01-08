//
//  TextTableViewCellModel.swift
//  PikabuFeed
//
//  Created by Nikita Rostovskii on 07.01.2021.
//

import Foundation

class TextTableViewCellModel: BaseTableViewCellModel {
    
    public let text: String
    
    public override var cellIdentifier: String {
        TextTableViewCell.cellIdentifier
    }
    
    public init(text: String) {
        self.text = text
    }
}
