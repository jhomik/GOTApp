//
//  GoTCustomCell.swift
//  GoTApp
//
//  Created by Jakub Homik on 23/04/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit

class GoTCustomCell: UITableViewCell {
    
    static let reuseID = "Article"
    
    private var isFavorite: Bool = false
    let favoriteButton = UIButton(type: .system)
    
    var article: Article? {
        didSet {
            refreshViews()
            setupFavoriteStarButton()
        }
    }
    
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
    
    func unfavoriteStarButton() {
        
    }
    
    private func setupFavoriteStarButton() {
        
        favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        favoriteButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        favoriteButton.addTarget(self, action: #selector(favoriteStarTapped), for: .touchUpInside)
        
        accessoryView = favoriteButton
    }
    
    @objc private func favoriteStarTapped() {
        updateFavorite(bool: !isFavorite)
    }
    
    private func updateFavorite(bool: Bool) {
        guard let article = article else { return }
        
        isFavorite = bool
        
        let unfavoriteStar = UIImage(systemName: "star")!
            .withTintColor(.systemBlue)
        let favoriteStar = UIImage(systemName: "star.fill")!
            .withTintColor(.systemYellow)
        
        if bool {
            favoriteButton.setImage(favoriteStar, for: .normal)
            ArticleManager.shared.save(favorites: article) { (error) in
                print(GoTError.invalidData)
            }
        } else {
            favoriteButton.setImage(unfavoriteStar, for: .normal)
            ArticleManager.shared.remove(favorites: article) { (error) in
                print(GoTError.invalidData)
            }
        }
    }
}
