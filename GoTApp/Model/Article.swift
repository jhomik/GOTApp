//
//  Characters.swift
//  GoTApp
//
//  Created by Jakub Homik on 07/04/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import Foundation

struct Article: Codable {
    
    var title: String
    var thumbnail: String?
    var abstract: String
    var url: String
}

struct ArticleResponse: Codable {
    
    var items: [Article]
}
