//
//  FeedDetailsRouter.swift
//  PikabuFeed
//
//  Created by Nikita Rostovskii on 07.01.2021.
//

import UIKit

final class FeedDetailsRouter: FeedDetailsRouterProtocol {
    
    private var onDismissAction: (() -> Void)?
    
    static func make(with story: StoryModel, feedService: FeedServiceProtocol, onDismiss: (() -> Void)? = nil) -> UIViewController {
        
        let view = FeedDetailsViewController()
        let router = FeedDetailsRouter(onDismiss: onDismiss)
        let interactor = FeedDetailsInteractor(story: story, feedService: feedService)
        let presenter = FeedDetailsPresenter()
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        
        let navigationController = UINavigationController(rootViewController: view)
        return navigationController
    }
    
    init(onDismiss: (() -> Void)?) {
        self.onDismissAction = onDismiss
    }
    
    func onDismiss() {
        onDismissAction?()
    }
}
