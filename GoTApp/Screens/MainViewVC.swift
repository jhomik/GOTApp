//
//  MainView.swift
//  GoTApp
//
//  Created by Jakub Homik on 07/04/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit

class MainViewVC: UIViewController {
    
    static let reuseID = "Article"
    
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Article")
    }
    
    func downloadArticles() {
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
        
        var cell = tableView.dequeueReusableCell(withIdentifier: MainViewVC.reuseID, for: indexPath)
        
        if cell.detailTextLabel == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: MainViewVC.reuseID)
        }
        
        cell.textLabel?.text = article?.items[indexPath.row].title
        cell.detailTextLabel?.text = article?.items[indexPath.row].abstract
        cell.detailTextLabel?.numberOfLines = 2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let article = article else { return }
        let detailVC = DetailViewVC(url: article.items[indexPath.row])
        
        detailVC.articleLabel.text = article.items[indexPath.row].title
        detailVC.abstractLabel.text = article.items[indexPath.row].abstract
        
        
//        NetworkManager.shared.downloadImage(from: article.items[indexPath.row].thumbnail ?? "") { [weak self, weak detailVC] (image) in
//                    DispatchQueue.main.async {
//                        detailVC?.imageArticle.image = image
//                        self?.tableView.reloadData()
//                    }
//                }
        
//        detailVC.setArticle(article.items[indexPath.row])
        
        
        detailVC.delegate = self
        detailVC.imageArticle.downloadThumbnail(article.items[indexPath.row])
        let modalDetailVC = UINavigationController(rootViewController: detailVC)
        present(modalDetailVC, animated: true)
    }
}

extension MainViewVC: detailVCDelegate {
    func didTapFullArticleButton(url: Article) {
        
        guard let basepath = article?.basepath else { return }
        
        guard let url = URL(string: basepath + url.url) else { return }
        presentSafariVC(with: url)
    }
}
