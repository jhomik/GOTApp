//
//  MainView.swift
//  GoTApp
//
//  Created by Jakub Homik on 07/04/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit

class MainViewVC: UIViewController {
    
    let defaults = UserDefaults.standard
    let keys = "favorites"
    
    var tableView = UITableView()
    var article: ArticleResponse?
    var spinner = UIActivityIndicatorView(style: .large)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        downloadArticles()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func showLoadingSpinner() {
        spinner.frame = view.bounds
        spinner.center = view.center
        spinner.startAnimating()
        spinner.backgroundColor = .systemBackground
        
        DispatchQueue.main.async {
            self.tableView.isHidden = true
            self.view.addSubview(self.spinner)
        }
    }
    
    func removeLoadingSpinner() {
        DispatchQueue.main.async {
            self.spinner.removeFromSuperview()
            self.tableView.isHidden = false
        }
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GoTCustomCell.self, forCellReuseIdentifier: GoTCustomCell.reuseID)
    }
    
    private func downloadArticles() {
        showLoadingSpinner()
        NetworkManager.shared.downloadArticles { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let articles):
                self.article = articles
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.removeLoadingSpinner()
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GoTCustomCell.reuseID, for: indexPath) as? GoTCustomCell else {
            return UITableViewCell()
        }
       
        
        cell.article = article?.items[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let article = article else { return }
        let detailVC = DetailViewVC(article: article.items[indexPath.row])
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
