//
//  NavigationCoordinator.swift
//  MVVM-C
//
//  Created by Tulio Parreiras on 15/06/20.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit

final class NavigationCoordinator: Coordinator {
    
    var presentedController: UIViewController? {
        return self.navigationController.children.last
    }
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(viewController: UIViewController) {
        self.navigationController.pushViewController(viewController, animated: false)
    }
    
    func presentArticleDetails(_ viewModel: ArticleViewModel) {
        let viewController = DetailViewVC(viewModel: viewModel)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
}

