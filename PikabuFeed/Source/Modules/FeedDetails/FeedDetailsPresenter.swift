//
//  FeedDetailsPresenter.swift
//  PikabuFeed
//
//  Created by Nikita Rostovskii on 07.01.2021.
//

import Foundation

final class FeedDetailsPresenter: FeedDetailsPresenterProtocol {
    
    weak var view: FeedDetailsViewProtocol?
    var router: FeedDetailsRouterProtocol?
    var interactor: FeedDetailsInteractorProtocol?
    
    func viewDidLoad() {
        interactor?.reloadData(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let story):
                let models = self.makeCellModels(from: story)
                self.view?.show(models)
                self.view?.updateFavouriteButtonState(isFavourite: story.isFavourite)
            case .failure(let error):
                self.view?.showError(message: error.localizedDescription)
            }
        })
    }
    
    func onDismiss() {
        router?.onDismiss()
    }
    
    func favouriteTap() {
        guard let interactor = interactor else { return }
        let newValue = !interactor.isStoryFavourite
        
        interactor.isStoryFavourite = newValue
        view?.updateFavouriteButtonState(isFavourite: newValue)
    }
    
    private func makeCellModels(from story: StoryModel) -> [BaseTableViewCellModel] {
        var result = [BaseTableViewCellModel]()
        
        let titleModel = TitleTableViewCellModel(text: story.title)
        result.append(titleModel)
        
        if let images = story.images, !images.isEmpty {
            let imagesModel = ImageContainerTableViewCellModel(images: images)
            result.append(imagesModel)
        }
        
        if let body = story.body {
            let bodyModel = TextTableViewCellModel(text: body)
            result.append(bodyModel)
        }
        
        return result
    }
}
