//
//  FeedListPresenter.swift
//  PikabuFeed
//
//  Created by Nikita Rostovskii on 07.01.2021.
//

import Foundation

final class FeedListPresenter: FeedListPresenterProtocol {
    
    weak var view: FeedListViewProtocol?
    var router: FeedListRouterProtocol?
    var interactor: FeedListInteractorProtocol?
    
    
    func viewDidLoad() {
        updateData()
    }
    
    func viewWillAppear() {
        updateView()
    }
    
    func pullToRefresTriggered() {
        updateData()
    }
    
    // MARK: - Private
    
    private func updateData() {
        interactor?.reloadData(completion: { [weak self] result in
            self?.updateView()
        })
    }
    
    private func updateView() {
        guard let interactor = interactor else { return }
        
        switch interactor.getCurrentItems() {
        case .failure(let error):
            view?.showError(message: error.localizedDescription)
        case .success(let models):
            view?.show(models.map { makeModel(from: $0) })
        }
    }
    
    private func makeModel(from story: StoryModel) -> StoryTableViewCellModel {
        let model = StoryTableViewCellModel(title: story.title,
                                            body: story.body,
                                            imageURL: story.images?.first,
                                            isFavourite: story.isFavourite)
        model.selectAction = { [weak self] in
            guard let self = self else { return }
            self.router?.showDetails(for: story, onDismiss: {
                self.updateView()
            })
        }
        model.favouriteTapAction = { newValue in
            story.isFavourite = newValue
            self.updateView()
        }
        return model
    }
}
