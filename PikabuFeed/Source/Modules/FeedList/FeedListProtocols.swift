//
//  FeedListProtocols.swift
//  PikabuFeed
//
//  Created by Nikita Rostovskii on 07.01.2021.
//

import UIKit

protocol FeedListViewProtocol: UIViewController {
    
    func show(_ models: [BaseTableViewCellModel])
    func showError(message: String)
}

protocol FeedListPresenterProtocol: class {
    
    func viewDidLoad()
    func viewWillAppear()
    func pullToRefresTriggered()
}

protocol FeedListInteractorProtocol: class {
    
    func getCurrentItems() -> Result<[StoryModel], Error>
    func reloadData(completion: @escaping (Result<[StoryModel], Error>) -> Void)
}

protocol FeedListRouterProtocol: class {
    
    func showDetails(for item: StoryModel, onDismiss: (() -> Void)?)
}
