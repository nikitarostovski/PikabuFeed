//
//  TitleTableViewCellModel.swift
//  PikabuFeed
//
//  Created by Nikita Rostovskii on 07.01.2021.
//

import Foundation

class TitleTableViewCellModel: BaseTableViewCellModel {
        
    public let text: String
    
    public override var cellIdentifier: String {
        TitleTableViewCell.cellIdentifier
    }
    
    public init(text: String) {
        self.text = text
    }
}
