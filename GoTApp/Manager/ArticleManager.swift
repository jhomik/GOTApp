//
//  ArticleManager.swift
//  GoTApp
//
//  Created by Jakub Homik on 26/04/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import Foundation

final class ArticleManager {
    
    static let shared = ArticleManager()
    private let defaults = UserDefaults.standard
    private(set) var articles = [Article]()
    
    init() {
        self.retrieveFavorites { result in
            
            switch result {
            case .success(let article):
                self.articles = article
            case .failure(let error):
                print(error)
            }
        }
    }
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    func retrieveFavorites(completion: @escaping (Result<[Article], GoTError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else { return }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Article].self, from: favoritesData)
            completion(.success(favorites))
        } catch {
            completion(.failure(GoTError.invalidData))
        }
    }
    
    func save(favorites: Article, completion: @escaping (GoTError?) -> Void) {
        guard !self.articles.contains(favorites) else { return }
        self.articles.append(favorites)
        self.save(completion: completion)
    }
    
    func remove(favorites: Article, completion: @escaping (GoTError?) -> Void) {
        articles.removeAll { (article) -> Bool in
            article.title == favorites.title && article.abstract == favorites.abstract
        }
        self.save(completion: completion)
    }
    
    private func save(completion: @escaping (GoTError?) -> Void) {
        do {
            let encoder = JSONEncoder()
            let saveFavorites = try encoder.encode(self.articles)
            defaults.set(saveFavorites, forKey: Keys.favorites)
            completion(nil)
        } catch {
            completion(.invalidData)
        }
    }
}
