//
//  MainTableViewController.swift
//  MVVM-C
//
//  Created by Usemobile on 09/06/20.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit

final class MainTableViewController: UITableViewController {
    
    var viewModel = [ArticleViewModel]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    weak var coordinator: NavigationCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(GoTCell.self, forCellReuseIdentifier: String(describing: GoTCell.self))
        
        NetworkManager.shared.downloadArticles { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(response):
                    self?.viewModel = response.items.map { ArticleViewModel(model: $0, isFavorited: false) }
                case .failure: break
                }
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
        self.coordinator?.presentArticleDetails(self.viewModel[indexPath.row])
    }

}
