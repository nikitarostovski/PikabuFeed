//
//  PikabuFeedServiceProtocol.swift
//  PikabuFeed
//
//  Created by Nikita Rostovskii on 07.01.2021.
//

import Foundation

protocol FeedServiceProtocol {
    
    func getCurrentItems() -> Result<[StoryModel], Error>
    
    func reloadFeed(completion: @escaping (Result<Void, Error>) -> Void)
    
    func getStoryDetails(with id: Int, completion: @escaping (Result<StoryModel, Error>) -> Void)
}
