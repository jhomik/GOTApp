//
//  NetworkManager.swift
//  GoTApp
//
//  Created by Jakub Homik on 07/04/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://gameofthrones.fandom.com/api/v1/Articles/Top?expand=1&category=Characters&limit=75"
    
    func downloadArticles(completion: @escaping (Result<ArticleResponse, Error>) -> Void) {
        
        guard let url = URL(string: baseURL) else {
            completion(.failure(GoTError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(.failure(GoTError.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(GoTError.invalidResponse))
                return
            }
            
            if let _ = error {
                completion(.failure(GoTError.invalidResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(ArticleResponse.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(GoTError.invalidData))
            }
            
        }
        task.resume()
    }
}
