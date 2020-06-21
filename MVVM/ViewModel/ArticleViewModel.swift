//
//  ArticleViewModel.swift
//  MVVM-C
//
//  Created by Tulio Parreiras on 09/06/20.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import Foundation

// ViewModel: Its responsible for holding the model and formatting it to be displayed to UI component, holding state

/*
 Model                     <---> ViewModel <---> UI
 (Article, ArticleManager) <---> ViewModel <---> (GotCell)
 */

final class ArticleViewModel {
    
    private let model: Article
    
    typealias FavoriteObserver = ((Bool) -> Void)
    var onFavorite = [NSObject: FavoriteObserver]()
    
    var title: String {
        return self.model.title
    }
    var abstract: String {
        return self.model.abstract
    }
    var thumbnail: String? {
        return self.model.thumbnail
    }
    var url: String {
        return self.model.url
    }
    
    private(set) var isFavorited: Bool {
        didSet {
            guard self.isFavorited != oldValue else { return }
            self.onFavorite.keys.forEach { key in
                self.onFavorite[key]?(self.isFavorited)
            }
        }
    }
    
    init(model: Article, isFavorited: Bool) {
        self.model = model
        self.isFavorited = isFavorited
    }
    
    func setFavorite() {
        self.isFavorited.toggle()
        if self.isFavorited {
            ArticleManager.shared.save(favorites: self.model) { _ in }
        } else {
            ArticleManager.shared.remove(favorites: self.model) { _ in }
        }
    }
    
    func updateFavoriteState() {
        self.isFavorited = ArticleManager.shared.articles.contains(self.model)
    }
    
}
