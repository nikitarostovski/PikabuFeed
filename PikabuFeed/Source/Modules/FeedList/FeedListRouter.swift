//
//  FeedListRouter.swift
//  PikabuFeed
//
//  Created by Nikita Rostovskii on 07.01.2021.
//

import UIKit

final class FeedListRouter: FeedListRouterProtocol {
    
    private weak var view: FeedListViewProtocol?
    private var feedService: FeedServiceProtocol
    
    static func make(feedService: FeedServiceProtocol, displayMode: FeedListDisplayMode) -> UIViewController {
        
        let view = FeedListViewController()
        let router = FeedListRouter(feedService: feedService)
        let interactor = FeedListInteractor(feedService: feedService, displayMode: displayMode)
        let presenter = FeedListPresenter()
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        router.view = view
        
        view.title = displayMode.title
        view.tabBarItem.title = displayMode.title
        view.tabBarItem.image = UIImage(named: displayMode.iconName)
        
        let navigationController = UINavigationController(rootViewController: view)
        navigationController.navigationBar.prefersLargeTitles = true
        
        return navigationController
    }
    
    init(feedService: FeedServiceProtocol) {
        self.feedService = feedService
    }
    
    func showDetails(for story: StoryModel, onDismiss: (() -> Void)?) {
        let details = FeedDetailsRouter.make(with: story, feedService: feedService, onDismiss: onDismiss)
        view?.present(details, animated: true)
    }
}
