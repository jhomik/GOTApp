//
//  DetailView.swift
//  GoTApp
//
//  Created by Jakub Homik on 07/04/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit
import SafariServices

class DetailViewVC: UIViewController {
    
    let articleLabel = GoTLabel(textAlignment: .center, fontSize: 24)
    let imageArticle = GoTImageThumbnail(frame: .zero)
    let abstractLabel = GoTLabel(textAlignment: .center, fontSize: 16)
    let safariButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
        configureSafariButton()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func presentSafariVC() {
        guard let url = URL(string: "https://gameofthrones.fandom.com)") else { return }

        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    func setArticle(_ article: Article) {
        articleLabel.text = article.title
        abstractLabel.text = article.abstract
    }
    
    private func configureSafariButton() {
        safariButton.setTitle("Go to full article", for: .normal)
        safariButton.backgroundColor = .systemGray
        safariButton.layer.cornerRadius = 10
        safariButton.addTarget(self, action: #selector(safariVC), for: .touchUpInside)
        safariButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func safariVC() {
        presentSafariVC()
        
    }
    
    private func configureUI() {
        view.addSubview(articleLabel)
        view.addSubview(abstractLabel)
        view.addSubview(imageArticle)
        view.addSubview(safariButton)
        
        
        NSLayoutConstraint.activate([
            articleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            articleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            articleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            articleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            abstractLabel.topAnchor.constraint(equalTo: articleLabel.bottomAnchor, constant: 10),
            abstractLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            abstractLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            abstractLabel.heightAnchor.constraint(equalToConstant: 100),
            
            imageArticle.topAnchor.constraint(equalTo: abstractLabel.bottomAnchor, constant: 10),
            imageArticle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageArticle.widthAnchor.constraint(equalToConstant: 300),
            imageArticle.heightAnchor.constraint(equalToConstant: 300),
            
            safariButton.topAnchor.constraint(equalTo: imageArticle.bottomAnchor, constant: 40),
            safariButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            safariButton.heightAnchor.constraint(equalToConstant: 50),
            safariButton.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
}
