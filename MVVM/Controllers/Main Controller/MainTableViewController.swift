//
//  MainTableViewController.swift
//  MVVM-C
//
//  Created by Tulio Parreiras on 09/06/20.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit

protocol ArticleLoader {
    func loadArticle(completion: @escaping(Result<ArticleResponse, Error>) -> Void)
}

final class MainTableViewController: UITableViewController {
    
    var viewModel = [ArticleViewModel]() { 
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var presentDetails: ((ArticleViewModel) -> Void)?
    weak var coordinator: NavigationCoordinator?
    var articleLoader: ArticleLoader?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(GoTCell.self, forCellReuseIdentifier: String(describing: GoTCell.self))
        
        self.loadArticles()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.forEach { $0.updateFavoriteState() }
    }

    private func loadArticles() {
        self.articleLoader?.loadArticle { [weak self] result in
            let resultExecution = {
                switch result {
                case let .success(response):
                    self?.viewModel = response.items.map { ArticleViewModel(model: $0, isFavorited: ArticleManager.shared.articles.contains($0)) }
                case .failure: break
                }
            }
            if Thread.isMainThread {
                resultExecution()
            } else {
                DispatchQueue.main.async(execute: resultExecution)
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GoTCell.self), for: indexPath) as! GoTCell
        cell.viewModel = self.viewModel[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presentDetails?(self.viewModel[indexPath.row])
    }

}

