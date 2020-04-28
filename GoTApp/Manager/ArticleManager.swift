//
//  ArticleManager.swift
//  GoTApp
//
//  Created by Jakub Homik on 26/04/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import Foundation

class ArticleManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func retrieveFavorites(completion: @escaping (Result<[Article], GoTError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else { return }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Article].self, from: favoritesData)
            completion(.success(favorites))
        } catch {
            completion(.failure(GoTError.invalidData))
        }
    }
    
    @discardableResult static func save(favorites: Article) -> GoTError? {
        do {
            let encoder = JSONEncoder()
            let saveFavorites = try encoder.encode(favorites)
            defaults.set(saveFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .invalidData
        }
    }
}
