//
//  MainView.swift
//  GoTApp
//
//  Created by Jakub Homik on 07/04/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit

class MainViewVC: UIViewController {
    
    var tableView = UITableView()
    var article: ArticleResponse?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        downloadArticles()
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Article")
        tableView.rowHeight = 80
    }
    
    func downloadArticles() {
        NetworkManager.shared.downloadArticles { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let articles):
                self.article = articles
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}


extension MainViewVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let art = article else { return 0 }
        
        return art.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Article")
        
        cell.textLabel?.text = article?.items[indexPath.row].title
        cell.detailTextLabel?.text = article?.items[indexPath.row].abstract
        cell.detailTextLabel?.numberOfLines = 2
        
        return cell
    }
    
    
}
