//
//  GoTCustomCell.swift
//  GoTApp
//
//  Created by Jakub Homik on 23/04/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit

class GoTCustomCell: UITableViewCell {
    
        var article: Article? {
            didSet {
                refreshViews()
                setupFavoriteStarButton()
            }
        }
    
    static let reuseID = "Article"
    
    let favoriteButton = UIButton(type: .system)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func refreshViews() {
        textLabel?.text = article?.title
        detailTextLabel?.text = article?.abstract
        detailTextLabel?.numberOfLines = 2
    }
    
    private func setupFavoriteStarButton() {
        let blueStar = UIImage(systemName: "star")!
//            .withTintColor(.systemBlue)
//            .withRenderingMode(.alwaysOriginal)
        let favoriteStar = UIImage(systemName: "star.fill")!
//            .withTintColor(.systemYellow)
//            .withRenderingMode(.alwaysOriginal)
        
        favoriteButton.setImage(blueStar, for: .normal)
        favoriteButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        favoriteButton.addTarget(self, action: #selector(favoriteStarTapped), for: .touchUpInside)
        
        accessoryView = favoriteButton
    }
    
    private func updateFavorite() {
        guard let article = article else { return }
        ArticleManager.save(favorites: article)
    }
    
    @objc private func favoriteStarTapped() {
        setupFavoriteStarButton()
        updateFavorite()
    }
}
