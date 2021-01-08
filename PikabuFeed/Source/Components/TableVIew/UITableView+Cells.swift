//
//  UITableView+Cells.swift
//  PikabuFeed
//
//  Created by Nikita Rostovskii on 07.01.2021.
//

import UIKit

public extension UITableView {
    
    func didSelectRowAt(indexPath: IndexPath, models: [BaseTableViewCellModel]) {
        guard indexPath.row >= 0, indexPath.row < models.count else { return }
        models[indexPath.row].selectAction?()
    }
    
    func numberOfSections(in models: [BaseTableViewCellModel]) -> NSInteger {
        return 1
    }
    
    func numberOfRows(in models: [BaseTableViewCellModel], section: NSInteger) -> NSInteger {
        return models.count
    }
    
    func dequeueReusableCell(with models: [BaseTableViewCellModel], indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row >= 0, indexPath.row < models.count else { return UITableViewCell() }
        let model = models[indexPath.row]
        var baseTableViewCell: BaseTableViewCell
        if let cell = dequeueReusableCell(withIdentifier: model.cellIdentifier) as? BaseTableViewCell {
            baseTableViewCell = cell
        } else {
            baseTableViewCell = BaseTableViewCell()
        }
        baseTableViewCell.setup(with: model)
        return baseTableViewCell
    }
}
