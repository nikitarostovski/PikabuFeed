//
//  FeedListViewController.swift
//  PikabuFeed
//
//  Created by Nikita Rostovskii on 07.01.2021.
//

import UIKit
import SnapKit

final class FeedListViewController: UIViewController, FeedListViewProtocol {
    
    
    // MARK: - Public variables
    
    var presenter: FeedListPresenterProtocol?
    
    // MARK: - Private variables
    
    private var cellModels: [BaseTableViewCellModel] = []
    
    // MARK: - UI
    
    private lazy var placeholderView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.text = nil
        return label
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(onTableViewRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.refreshControl = refreshControl
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInset.top = 16
        tableView.contentInset.bottom = 16
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        
        tableView.register(StoryTableViewCell.self, forCellReuseIdentifier: StoryTableViewCell.cellIdentifier)
        
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        }
        
        view.addSubview(tableView)
        view.addSubview(placeholderView)
        placeholderView.addSubview(placeholderLabel)
        
        tableView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        placeholderLabel.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        placeholderView.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
            maker.width.equalTo(view.snp.width).multipliedBy(0.5)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    func show(_ models: [BaseTableViewCellModel]) {
        hideError()
        cellModels = models
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
    
    // MARK: - Actions
    
    @objc private func onTableViewRefresh() {
        hideError()
        presenter?.pullToRefresTriggered()
    }
    
    // MARK: - Private
    
    func hideError() {
        placeholderLabel.text = nil
    }
    
    func showError(message: String) {
        refreshControl.endRefreshing()
        placeholderLabel.text = message
    }
}


// MARK: - UITableViewDelegate

extension FeedListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.didSelectRowAt(indexPath: indexPath, models: cellModels)
    }
}

// MARK: - UITableViewDataSource

extension FeedListViewController: UITableViewDataSource {
    
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
