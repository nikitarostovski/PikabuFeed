//
//  TextTableViewCell.swift
//  PikabuFeed
//
//  Created by Nikita Rostovskii on 07.01.2021.
//

import UIKit

final class TextTableViewCell: BaseTableViewCell {
    
    private let horizontalInset: CGFloat = 16
    private let verticalInset: CGFloat = 8
    
    private lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.text = nil
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        contentView.addSubview(bodyLabel)
        
        bodyLabel.snp.makeConstraints { maker in
            maker.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(verticalInset)
            maker.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-verticalInset)
            maker.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading).offset(horizontalInset)
            maker.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing).offset(-horizontalInset)
        }
    }
    
    override func updateAppearance() {
        super.updateAppearance()
        guard let model = model as? TextTableViewCellModel else { return }
        
        bodyLabel.text = model.text
    }
}
