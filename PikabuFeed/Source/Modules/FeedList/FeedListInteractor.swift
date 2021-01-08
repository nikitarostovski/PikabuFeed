//
//  FeedListInteractor.swift
//  PikabuFeed
//
//  Created by Nikita Rostovskii on 07.01.2021.
//

import Foundation

final class FeedListInteractor: FeedListInteractorProtocol {
    
    private var displayMode: FeedListDisplayMode
    private var feedService: FeedServiceProtocol
    
    init(feedService: FeedServiceProtocol, displayMode: FeedListDisplayMode) {
        self.displayMode = displayMode
        self.feedService = feedService
    }
    
    func getCurrentItems() -> Result<[StoryModel], Error> {
        switch feedService.getCurrentItems() {
        case .failure(let error):
            return .failure(error)
        case .success(let models):
            switch displayMode {
            case .all:
                return .success(models)
            case .favourites:
                return .success(models.filter { $0.isFavourite })
            }
        }
    }
    
    func reloadData(completion: @escaping (Result<[StoryModel], Error>) -> Void) {
        feedService.reloadFeed(completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case.failure(let error):
                completion(.failure(error))
            case .success(_):
                completion(self.getCurrentItems())
            }
        })
    }
}
