//
//  GoTCell.swift
//  MVVM-C
//
//  Created by Tulio Parreiras on 09/06/20.
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
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
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
        self.detailTextLabel?.numberOfLines = 0
        self.selectionStyle = .none
        self.contentView.addSubview(self.favoriteButton)
        self.favoriteButton.addTarget(self, action: #selector(self.favoriteAction), for: .touchUpInside)
        let buttonSize: CGFloat = 44
        self.favoriteButton.frame = CGRect(origin: .zero, size: .init(width: buttonSize, height: buttonSize))
        self.accessoryView = self.favoriteButton
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
    
    @objc func favoriteAction() {
        self.viewModel?.setFavorite()
    }
    
}
