//
//  FavoritesVC.swift
//  GoTApp
//
//  Created by Jakub Homik on 14/04/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {
    
    var tableView = UITableView()
    weak var coordinator: NavigationCoordinator?
    
    var favoritesArticle: [Article] {
        return ArticleManager.shared.articles
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    func configureTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(GoTFavoriteCustomCell.self, forCellReuseIdentifier: GoTFavoriteCustomCell.reuseID)
    }
}

extension FavoritesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesArticle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GoTFavoriteCustomCell.reuseID, for: indexPath) as? GoTFavoriteCustomCell else {
            return UITableViewCell()
        }
        
        cell.favorite = favoritesArticle[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.coordinator?.presentArticleDetails(
            ArticleViewModel(model: self.favoritesArticle[indexPath.row],
                             isFavorited: true))
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        ArticleManager.shared.remove(favorites: favoritesArticle[indexPath.row]) { (error) in
            guard let error = error else {
                self.tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
            print(error)
        }
    }
}
