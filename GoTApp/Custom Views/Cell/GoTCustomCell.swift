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
    
    let favoriteButton = UIButton(type: .system)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupFavoriteStarButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(_ article: Article?) {
        textLabel?.text = article?.title
        detailTextLabel?.text = article?.abstract
        detailTextLabel?.numberOfLines = 2
    }
    
    func setupFavoriteStarButton() {
        favoriteButton.setImage(UIImage(named: "favoriteStar"), for: .normal)
        favoriteButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        favoriteButton.addTarget(self, action: #selector(favoriteStarTapped), for: .touchUpInside)
        
        accessoryView = favoriteButton
    }
    
    @objc func favoriteStarTapped() {
        favoriteButton.tintColor = .systemYellow
    }
}
