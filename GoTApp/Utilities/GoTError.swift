//
//  GoTError.swift
//  GoTApp
//
//  Created by Jakub Homik on 07/04/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import Foundation

enum GoTError: String, Error {
    case invalidURL = "Invalid URL."
    case invalidData = "Invalid Data."
    case invalidResponse = "Invalid response, please check you internet connection."
}
