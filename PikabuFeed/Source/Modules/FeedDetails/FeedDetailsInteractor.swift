//
//  FeedDetailsInteractor.swift
//  PikabuFeed
//
//  Created by Nikita Rostovskii on 07.01.2021.
//

import Foundation

final class FeedDetailsInteractor: FeedDetailsInteractorProtocol {
    
    private var feedService: FeedServiceProtocol
    
    private var story: StoryModel
    
    var isStoryFavourite: Bool {
        get {
            story.isFavourite
        }
        set {
            story.isFavourite = newValue
        }
    }
    
    init(story: StoryModel, feedService: FeedServiceProtocol) {
        self.story = story
        self.feedService = feedService
    }
    
    func reloadData(completion: @escaping (Result<StoryModel, Error>) -> Void) {
        feedService.getStoryDetails(with: story.id, completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let story):
                self.story = story
                completion(.success(story))
            }
        })
    }
}
