//
//  MainCoordinator.swift
//  MVVM-C
//
//  Created by TulioParreiras on 09/06/20.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit

protocol Coordinator { }

public final class MainCoordinator: Coordinator {
    
    var window: UIWindow
    var tabBarController: UITabBarController
     
    var children: [Coordinator] = []
    
    public init(window: UIWindow, tabBarController: UITabBarController) {
        self.window = window
        self.tabBarController = tabBarController
    }
    
    public func start() {
        let mainNavigationCoordinator = NavigationCoordinator(navigationController: .init())
        mainNavigationCoordinator.start(viewController: MainTableViewController())
        self.children = [mainNavigationCoordinator]
        self.tabBarController.setViewControllers([mainNavigationCoordinator.navigationController], animated: false)
        self.window.rootViewController = self.tabBarController
        self.window.makeKeyAndVisible()
    }
    
}

final class NavigationCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(viewController: UIViewController) {
        self.navigationController.pushViewController(viewController, animated: false)
    }
    
    func presentArticleDetails(_ viewModel: ArticleViewModel) {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .yellow
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
}
