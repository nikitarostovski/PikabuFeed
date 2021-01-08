//
//  PikabuAPIService.swift
//  PikabuFeed
//
//  Created by Nikita Rostovskii on 07.01.2021.
//

import Foundation

final class PikabuAPIService: FeedServiceProtocol {
    
    enum Endpoint {
        
        case feed
        case story(id: Int)
        
        var url: URL? {
            var result = "https://pikabu.ru/page/interview/mobile-app/test-api"
            switch self {
            case .feed:
                result = "\(result)/feed.php"
            case .story(let id):
                result = "\(result)/story.php?id=\(id)"
            }
            return URL(string: result)
        }
    }
    
    private var session: URLSession = .shared
    
    private var currentItems: [StoryModel] = []
    private var currentError: Error?
    
    
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
        guard let url = Endpoint.feed.url else {
            completion(.failure(PikabuAPIError.wrongURL))
            return
        }
        session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let message = error?.localizedDescription {
                    let error = PikabuAPIError.requestFailure(message: message)
                    self.currentError = error
                    completion(.failure(error))
                    return
                }
                do {
                    if let data = data {
                        let items = try JSONDecoder().decode([PikabuStoryAPIModel].self, from: data)
                        let result = items.map { StoryModel($0) }
                        self.currentItems = result
                        completion(.success(()))
                        return
                    } else {
                        let error = PikabuAPIError.responseDataError
                        self.currentError = error
                        completion(.failure(error))
                        return
                    }
                } catch {
                    self.currentError = error
                    completion(.failure(PikabuAPIError.responseDataError))
                    return
                }
            }
        }.resume()
    }
    
    func getStoryDetails(with id: Int, completion: @escaping (Result<StoryModel, Error>) -> Void) {
        guard let url = Endpoint.story(id: id).url else {
            completion(.failure(PikabuAPIError.wrongURL))
            return
        }
        session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let message = error?.localizedDescription {
                    completion(.failure(PikabuAPIError.requestFailure(message: message)))
                    return
                }
                do {
                    if let data = data {
                        let item = try JSONDecoder().decode(PikabuStoryAPIModel.self, from: data)
                        let result = StoryModel(item)
                        completion(.success(result))
                        return
                    } else {
                        completion(.failure(PikabuAPIError.responseDataError))
                        return
                    }
                } catch {
                    completion(.failure(PikabuAPIError.responseDataError))
                    return
                }
            }
        }.resume()
    }
}
