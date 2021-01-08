//
//  FeedDetailsProtocol.swift
//  PikabuFeed
//
//  Created by Nikita Rostovskii on 07.01.2021.
//

import UIKit

protocol FeedDetailsViewProtocol: UIViewController {
    
    func showError(message: String)
    
    func show(_ models: [BaseTableViewCellModel])
    func updateFavouriteButtonState(isFavourite: Bool)
}

protocol FeedDetailsPresenterProtocol: class {
    
    func viewDidLoad()
    func onDismiss()
    func favouriteTap()
}

protocol FeedDetailsInteractorProtocol: class {
    
    var isStoryFavourite: Bool { get set }
    
    func reloadData(completion: @escaping (Result<StoryModel, Error>) -> Void)
}

protocol FeedDetailsRouterProtocol: class {
    
    func onDismiss()
}

