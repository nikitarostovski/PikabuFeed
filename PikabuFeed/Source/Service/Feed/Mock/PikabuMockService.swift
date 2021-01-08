//
//  PikabuMockService.swift
//  PikabuFeed
//
//  Created by Nikita Rostovskii on 07.01.2021.
//

import Foundation

final class PikabuMockService: FeedServiceProtocol {
    
    // MARK: - Nested types
    
    enum SimulationMode {
        case items
        case itemsWithDelay
        case error
        case errorWithDelay
    }
    
    // MARK: - Constants
    
    private let demoItems: [StoryModel] = [
        StoryModel(id: 1, title: "Title 1", body: "Body 1", images: ["https://cs6.pikabu.ru/post_img/2017/09/28/5/1506579123185937509.jpg",
                                                                      "https://cs6.pikabu.ru/post_img/2017/09/28/5/1506579123185937509.jpg",
                                                                      "https://cs6.pikabu.ru/post_img/2017/09/28/5/1506579123185937509.jpg",
                                                                      "https://cs6.pikabu.ru/post_img/2017/09/28/5/1506579123185937509.jpg"]),
        StoryModel(id: 2, title: "Title 2", body: "Body 2", images: nil),
        StoryModel(id: 3, title: "Title 3", body: "Body 3", images: nil),
        StoryModel(id: 4, title: "Title 4", body: "Body 4", images: nil),
        StoryModel(id: 5, title: "Title 5", body: "Body 5", images: nil),
        StoryModel(id: 6, title: "Title 6", body: "Body 6", images: nil),
    ]
    
    // MARK: - Public variables
    
    var mode = SimulationMode.errorWithDelay
    
    // MARK: - Private variables
    
    private let queue = DispatchQueue.global(qos: .background)
    
    private var currentItems: [StoryModel] = []
    private var currentError: Error?
    
    
    // MARK: - Public
    
    
    func getCurrentItems() -> Result<[StoryModel], Error> {
        if let error = currentError {
            return .failure(error)
        } else {
            return .success(currentItems)
        }
    }
    
    func reloadFeed(completion: @escaping (Result<Void, Error>) -> Void) {
        currentItems.removeAll()
        currentError = nil
        switch mode {
        case .items:
            getItemsImmediately(completion: completion)
        case .itemsWithDelay:
            getItemsWithDelay(completion: completion)
        case .error:
            getItemsWithErrorImmediately(completion: completion)
        case .errorWithDelay:
            getItemsWithDelayAndError(completion: completion)
        }
    }
    
    func getStoryDetails(with id: Int, completion: @escaping (Result<StoryModel, Error>) -> Void) {
        switch mode {
        case .items:
            getDetailsImmediately(with: id, completion: completion)
        case .itemsWithDelay:
            getDetailsWithDelay(with: id, completion: completion)
        case .error:
            getDetailsWithErrorImmediately(with: id, completion: completion)
        case .errorWithDelay:
            getDetailsWithDelayAndError(with: id, completion: completion)
        }
    }
    
    // MARK: - Private
    
    // List
    
    private func getItemsWithDelay(completion: @escaping (Result<Void, Error>) -> Void) {
        queue.asyncAfter(deadline: .now() + 2) { [weak self] in
            DispatchQueue.main.async {
                self?.getItemsImmediately(completion: completion)
            }
        }
    }
    
    private func getItemsWithDelayAndError(completion: @escaping (Result<Void, Error>) -> Void) {
        queue.asyncAfter(deadline: .now() + 2) { [weak self] in
            DispatchQueue.main.async {
                self?.getItemsWithErrorImmediately(completion: completion)
            }
        }
    }
    
    private func getItemsWithErrorImmediately(completion: @escaping (Result<Void, Error>) -> Void) {
        let error = PikabuMockError.generalError
        currentError = error
        completion(.failure(error))
    }
    
    private func getItemsImmediately(completion: @escaping (Result<Void, Error>) -> Void) {
        currentItems = demoItems
        completion(.success(()))
    }
    
    // Details
    
    private func getDetailsWithDelay(with id: Int, completion: @escaping (Result<StoryModel, Error>) -> Void) {
        queue.asyncAfter(deadline: .now() + 2) { [weak self] in
            DispatchQueue.main.async {
                self?.getDetailsImmediately(with: id, completion: completion)
            }
        }
    }
    
    private func getDetailsWithDelayAndError(with id: Int, completion: @escaping (Result<StoryModel, Error>) -> Void) {
        queue.asyncAfter(deadline: .now() + 2) { [weak self] in
            DispatchQueue.main.async {
                self?.getDetailsWithErrorImmediately(with: id, completion: completion)
            }
        }
    }
    
    private func getDetailsWithErrorImmediately(with id: Int, completion: @escaping (Result<StoryModel, Error>) -> Void) {
        completion(.failure(PikabuMockError.generalError))
    }
    
    private func getDetailsImmediately(with id: Int, completion: @escaping (Result<StoryModel, Error>) -> Void) {
        if let first = self.currentItems.first(where: { $0.id == id }) {
            completion(.success(first))
        } else {
            completion(.failure(PikabuMockError.generalError))
        }
    }
}
