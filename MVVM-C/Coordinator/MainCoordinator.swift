//
//  MainCoordinator.swift
//  MVVM-C
//
//  Created by TulioParreiras on 09/06/20.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit

public final class MainCoordinator {
    
    var window: UIWindow
    var tabBarController: UITabBarController
    
    public init(window: UIWindow, tabBarController: UITabBarController) {
        self.window = window
        self.tabBarController = tabBarController
    }
    
    public func start() {
        self.tabBarController.setViewControllers([MainTableViewController()], animated: false)
        self.window.rootViewController = self.tabBarController
        self.window.makeKeyAndVisible()
    }
    
}
