//
//  ArticleModel.swift
//  MVVM-C
//
//  Created by Usemobile on 09/06/20.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import Foundation

struct Article: Codable, Equatable {
    
    let title: String
    let thumbnail: String?
    let abstract: String
    let url: String
}

struct ArticleResponse: Codable {
    var items: [Article]
}
