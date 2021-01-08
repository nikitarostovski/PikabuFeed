//
//  StoryTableViewCell.swift
//  PikabuFeed
//
//  Created by Nikita Rostovskii on 07.01.2021.
//

import UIKit

final class StoryTableViewCell: BaseTableViewCell {
    
    private let previewImageSize: CGFloat = 64
    
    private let favouriteButtonSize: CGFloat = 44
    
    private let horizontalInset: CGFloat = 16
    private let verticalInset: CGFloat = 8
    
    private weak var item: StoryModel?
    
    private var onFavouriteChange: (() -> Void)?
    
    private lazy var pictureImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "PreviewEmpty"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var favouriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        button.addTarget(self, action: #selector(favouriteTap), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        clipsToBounds = true
        
        contentView.addSubview(pictureImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(bodyLabel)
        contentView.addSubview(favouriteButton)
    
        
        pictureImageView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(horizontalInset)
            make.top.equalToSuperview().offset(verticalInset)
            make.bottom.lessThanOrEqualToSuperview().offset(-verticalInset)
            make.size.equalTo(CGSize(width: previewImageSize, height: previewImageSize))
        }
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(pictureImageView.snp.trailing).offset(horizontalInset)
            maker.top.equalTo(pictureImageView.snp.top)
            maker.trailing.equalTo(horizontalInset).offset(-2 * horizontalInset - favouriteButtonSize)
        }

        bodyLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(titleLabel.snp.leading)
            maker.top.equalTo(titleLabel.snp.bottom).offset(verticalInset)
            maker.trailing.equalTo(titleLabel.snp.trailing)
            maker.bottom.lessThanOrEqualToSuperview().offset(-verticalInset)
        }
        
        favouriteButton.snp.makeConstraints { (maker) in
            maker.size.equalTo(CGSize(width: favouriteButtonSize, height: favouriteButtonSize))
            maker.top.equalToSuperview().offset(verticalInset)
            maker.trailing.equalToSuperview().offset(-horizontalInset)
        }
    }
    
    override func updateAppearance() {
        super.updateAppearance()
        guard let model = model as? StoryTableViewCellModel else { return }
        
        titleLabel.text = model.title
        bodyLabel.text = model.body
        updateFavouriteButtonState(model.isFavourite)
        
        ImageDownloadService.loadImage(from: model.imageURL) { [weak self] image in
            self?.pictureImageView.image = image
        }
    }
    
    @objc private func favouriteTap() {
        guard let model = model as? StoryTableViewCellModel else { return }
        
        model.isFavourite.toggle()
        model.favouriteTapAction?(model.isFavourite)
        updateFavouriteButtonState(model.isFavourite)
    }
    
    private func updateFavouriteButtonState(_ isFavourite: Bool) {
        let imageName = isFavourite ? "icHeartFilled" : "icHeartOutlined"
        favouriteButton.setImage(UIImage(named: imageName), for: .normal)
    }
}
