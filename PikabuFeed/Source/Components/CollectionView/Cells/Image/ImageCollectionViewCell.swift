//
//  ImageCollectionViewCell.swift
//  PikabuFeed
//
//  Created by Nikita Rostovskii on 07.01.2021.
//

import UIKit

final class ImageCollectionViewCell: UICollectionViewCell {
    
    public static var cellIdentifier: String {
        return String(describing: self)
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private lazy var blurView: UIVisualEffectView = {
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        
        return blurView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        addSubview(backgroundImageView)
        addSubview(blurView)
        addSubview(imageView)
        
        backgroundImageView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        blurView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
    
    func configure(with imageUrl: String?) {
        ImageDownloadService.loadImage(from: imageUrl) { [weak self] image in
            self?.backgroundImageView.image = image
            self?.imageView.image = image
        }
    }
}
