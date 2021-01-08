//
//  BaseTableViewCellModel.swift
//  PikabuFeed
//
//  Created by Nikita Rostovskii on 07.01.2021.
//

import Foundation

open class BaseTableViewCellModel {
    
    open var cellIdentifier: String {
        return ""
    }
    
    open var selectAction: (() -> Void)?
    open var userInteractionEnabled = true
    
    public init(selectAction: (() -> Void)? = nil) {
        self.selectAction = selectAction
    }
}
