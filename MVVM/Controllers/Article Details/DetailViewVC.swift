//
//  DetailView.swift
//  GoTApp
//
//  Created by Jakub Homik on 07/04/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit

final class DetailViewVC: UIViewController {
    
    private let articleLabel = GoTLabel(textAlignment: .center, fontSize: 24)
    private let imageArticle = GoTImageThumbnail(frame: .zero)
    private let abstractLabel = GoTLabel(textAlignment: .center, fontSize: 16)
    private let safariButton = UIButton()
    var viewModel: ArticleViewModel?
    
    init(viewModel: ArticleViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureUI()
        configureSafariButton()
        setup()
        setupViewModel()
    }
    
    private func setup() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureSafariButton() {
        safariButton.setTitle("Go to full article", for: .normal)
        safariButton.backgroundColor = .systemGray
        safariButton.layer.cornerRadius = 10
        safariButton.addTarget(self, action: #selector(safariVC), for: .touchUpInside)
        safariButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func safariVC() {
        let basepath = "https://gameofthrones.fandom.com"
        
        guard let link = viewModel?.url, let url = URL(string: basepath + link) else { return }
        // That should be handled into the coordinator -> presentSafariVC(with: url)
    }
    
    private func setupViewModel() {
        self.articleLabel.text = self.viewModel?.title
        self.abstractLabel.text = self.viewModel?.abstract
        self.viewModel?.onFavorite[self] = { [weak self] _ in
            self?.configureNavBar()
        }
        self.configureNavBar()
        
        guard let link = viewModel?.thumbnail else { return }
        self.imageArticle.downloadThumbnail(link)
    }
    
    private func configureNavBar() {
        let barButtonSystemItem: UIBarButtonItem.SystemItem = (self.viewModel?.isFavorited == true ? .trash : .add)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: barButtonSystemItem, target: self, action: #selector(addToFavorites))
    }
    
    @objc func addToFavorites() {
        self.viewModel?.setFavorite()
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
