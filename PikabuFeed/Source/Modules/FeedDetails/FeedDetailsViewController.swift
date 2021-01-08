//
//  FeedDetailsViewController.swift
//  PikabuFeed
//
//  Created by Nikita Rostovskii on 07.01.2021.
//

import UIKit

final class FeedDetailsViewController: UIViewController, FeedDetailsViewProtocol {

    var presenter: FeedDetailsPresenterProtocol?
    private var cellModels: [BaseTableViewCellModel] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(TextTableViewCell.self, forCellReuseIdentifier: TextTableViewCell.cellIdentifier)
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.cellIdentifier)
        tableView.register(ImageContainerTableViewCell.self, forCellReuseIdentifier: ImageContainerTableViewCell.cellIdentifier)
        
        return tableView
    }()
    
    private lazy var favouriteButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(favouriteTap))
        return button
    }()
    
    private lazy var closeButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "icCross"), style: .plain, target: self, action: #selector(closeTap))
        return button
    }()
    
    override func loadView() {
        super.loadView()
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = favouriteButton
        navigationItem.leftBarButtonItem = closeButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        presenter?.onDismiss()
        super.viewWillDisappear(animated)
    }
    
    @objc private func favouriteTap() {
        presenter?.favouriteTap()
    }
    
    @objc private func closeTap() {
        dismiss(animated: true, completion: nil)
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func show(_ models: [BaseTableViewCellModel]) {
        cellModels = models
        tableView.reloadData()
    }
    
    func updateFavouriteButtonState(isFavourite: Bool) {
        let imageName = isFavourite == true ? "icHeartFilled" : "icHeartOutlined"
        favouriteButton.image = UIImage(named: imageName)
    }
}

// MARK: - UITableViewDelegate

extension FeedDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource

extension FeedDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        tableView.numberOfSections(in: cellModels)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.numberOfRows(in: cellModels, section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(with: cellModels, indexPath: indexPath)
    }
}
