//
//  MainTabBarController.swift
//  PikabuFeed
//
//  Created by Nikita Rostovskii on 07.01.2021.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    private var feedService: FeedServiceProtocol
    
    init() {
        
        feedService = PikabuAPIService()
        
        // uncomment to use fake service
        // feedService = PikabuMockService()
        
        super.init(nibName: nil, bundle: nil)
        
        self.viewControllers = [
            FeedListRouter.make(feedService: feedService, displayMode: .all),
            FeedListRouter.make(feedService: feedService, displayMode: .favourites)
        ]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
