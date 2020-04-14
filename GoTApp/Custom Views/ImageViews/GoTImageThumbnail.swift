//
//  GoTImageThumbnail.swift
//  GoTApp
//
//  Created by Jakub Homik on 08/04/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit

class GoTImageThumbnail: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 20
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadThumbnail(_ article: Article) {
        guard let article = article.thumbnail else { return }
        NetworkManager.shared.downloadImage(from: article) { [weak self] (image) in
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}
