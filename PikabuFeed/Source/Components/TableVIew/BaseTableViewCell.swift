//
//  BaseTableViewCell.swift
//  PikabuFeed
//
//  Created by Nikita Rostovskii on 07.01.2021.
//

import UIKit

open class BaseTableViewCell: UITableViewCell {
    
    open weak var model: BaseTableViewCellModel?
    
    public static var cellIdentifier: String {
        return String(describing: Self.self)
    }
    
    open func setup(with model: BaseTableViewCellModel) {
        self.model = model
        updateAppearance()
    }
    
    open func updateAppearance() {
        isUserInteractionEnabled = model?.userInteractionEnabled ?? true
        selectionStyle = .none
    }
}
