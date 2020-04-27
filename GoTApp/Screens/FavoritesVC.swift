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
    var favoritesArticle: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
        ArticleManager.retrieveFavorites { (result) in
            switch result {
            case .success(let favorites):
                print(favorites)
            case .failure(let error):
                break
            }
        }
    }
    
    func configureTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ArticleFavorites")
    }
}

extension FavoritesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesArticle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleFavorites", for: indexPath)
        cell.textLabel?.text = "test"
        
        return cell
    }
    
    
}
