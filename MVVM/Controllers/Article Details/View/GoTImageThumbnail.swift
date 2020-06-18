//
//  GoTImageThumbnail.swift
//  MVVM-C
//
//  Created by Tulio Parreiras on 15/06/20.
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
    
    func downloadThumbnail(_ link: String) {
        NetworkManager.shared.downloadImage(from: link) { [weak self] (image) in
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}

