//
//  SceneDelegate.swift
//  GoTApp
//
//  Created by Jakub Homik on 07/04/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit
import MVVM

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
//        let mainViewVC = UINavigationController(rootViewController: MainViewVC())
        
        let window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window.windowScene = windowScene
        self.window = window
        
        self.mvvmStart(window: window)
//        self.mvcStart(window: window)
    }
    
    func mvvmStart(window: UIWindow) {
        let coordinator = MainCoordinator(window: window, tabBarController: TabBarController())
        coordinator.start()
        self.coordinator = coordinator
    }
    
    // MARK: - OLD CODE (Should be removed)
    
    func mvcStart(window: UIWindow) {
        window.rootViewController = TabBarController()
        window.makeKeyAndVisible()
    }
    
    func MainVCNavigationController() -> UINavigationController {
        let mainVC = MainViewVC()
        mainVC.title = "Articles"
        mainVC.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 0)
        return UINavigationController(rootViewController: mainVC)
    }
    
    func FavoritesVCNavigationController() -> UINavigationController {
        let favoritesVC = FavoritesVC()
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favoritesVC)
    }
    
    func TabBarController() -> UITabBarController {
        let tabBar = UITabBarController()
        tabBar.viewControllers = [MainVCNavigationController(), FavoritesVCNavigationController()]
        
        return tabBar
    }
        
    

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

