//
//  MainCoordinator.swift
//  MVVM-C
//
//  Created by TulioParreiras on 09/06/20.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit

protocol Coordinator {
    var presentedController: UIViewController? { get }
}

public final class MainCoordinator: Coordinator {
    
    public var presentedController: UIViewController? {
        return self.children.last?.presentedController ?? self.tabBarController.children[self.tabBarController.selectedIndex]
    }
    
    var window: UIWindow
    var tabBarController: UITabBarController
     
    var children: [Coordinator] = []
    
    public init(window: UIWindow, tabBarController: UITabBarController) {
        self.window = window
        self.tabBarController = tabBarController
    }
    
    public func start() {
        let favoriteCoordinator = self.getFavoriteTab()
        let mainNavigationCoordinator = self.getMainTab()
        
        self.children = [mainNavigationCoordinator, favoriteCoordinator]
        self.tabBarController.setViewControllers([mainNavigationCoordinator.navigationController, favoriteCoordinator.navigationController], animated: false)
        self.window.rootViewController = self.tabBarController
        self.window.makeKeyAndVisible()
    }
    
    private func getMainTab() -> NavigationCoordinator {
        let mainNavigationCoordinator = NavigationCoordinator()
        let mainTableController = MainTableViewController()
        mainTableController.title = "Feed"
        mainNavigationCoordinator.start(viewController: mainTableController)
        mainTableController.coordinator = mainNavigationCoordinator
        
        let mainNavigationController = mainNavigationCoordinator.navigationController
        mainNavigationController.tabBarItem = UITabBarItem(
            title: mainTableController.title,
            image: UIImage(systemName: "folder"),
            selectedImage: UIImage(systemName: "folder.fill"))
        
        return mainNavigationCoordinator
    }
    
    private func getFavoriteTab() -> NavigationCoordinator {
        let favoriteCoordinator = NavigationCoordinator()
        
        let favoriteVC = FavoritesVC()
        favoriteVC.coordinator = favoriteCoordinator
        
        favoriteCoordinator.start(viewController: favoriteVC)
        favoriteVC.title = "Favorites"
        let favoriteNavigationController = favoriteCoordinator.navigationController
        favoriteNavigationController.tabBarItem = UITabBarItem(
            title: favoriteVC.title,
            image: UIImage(systemName: "star"),
            selectedImage: UIImage(systemName: "star.fill"))
        return favoriteCoordinator
    }
    
}
