//
//  GoTCell.swift
//  MVVM-C
//
//  Created by Usemobile on 09/06/20.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit

class GoTCell: UITableViewCell {
    
    var viewModel: ArticleViewModel? {
        didSet {
            self.setupViewModel()
        }
    }
    private var favoriteButton = UIButton(type: .system)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.viewModel?.onFavorite[self] = nil
    }
    
    private func setupUI() {
        self.selectionStyle = .none
        self.contentView.addSubview(self.favoriteButton)
        self.contentView.addConstraints([
            self.favoriteButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 8),
            self.favoriteButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.favoriteButton.heightAnchor.constraint(equalTo: self.favoriteButton.widthAnchor),
            self.favoriteButton.widthAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupViewModel() {
        self.textLabel?.text = self.viewModel?.title
        self.detailTextLabel?.text = self.viewModel?.abstract
        self.setButtonImage(isFavorited: self.viewModel?.isFavorited ?? false)
        self.viewModel?.onFavorite[self] = { [weak self] isFavorited in
            self?.setButtonImage(isFavorited: isFavorited)
        }
    }
    
    private func setButtonImage(isFavorited: Bool) {
        let unfavoriteStar = UIImage(systemName: "star")
        let favoriteStar = UIImage(systemName: "star.fill")
        self.favoriteButton.setImage(isFavorited ? favoriteStar : unfavoriteStar, for: .normal)
    }
    
}
