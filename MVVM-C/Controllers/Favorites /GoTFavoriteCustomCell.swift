//
//  GoTFavoriteCustomCell.swift
//  GoTApp
//
//  Created by Jakub Homik on 29/04/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit

class GoTFavoriteCustomCell: UITableViewCell {
    
    static let reuseID = "FavoritesCell"
    
    var favorite: Article? {
        didSet {
            refreshViews()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func refreshViews() {
        textLabel?.text = favorite?.title
        detailTextLabel?.text = favorite?.abstract
        detailTextLabel?.numberOfLines = 2
        accessoryType = .disclosureIndicator
    }
    
}
