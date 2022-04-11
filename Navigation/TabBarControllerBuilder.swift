//
//  TabBarControllerBuilder.swift
//  Navigation
//
//  Created by Anna Tsvetkova on 22.03.2022.
//

import UIKit

class TabBarControllerBuilder {
    static func build() -> UITabBarController {
        let mainTabBarController = UITabBarController()
        let feedNavigationController = UINavigationController(rootViewController: FeedViewController())
//        let profileNavigationController = UINavigationController(rootViewController: ProfileViewController())
        let loginNavigationController = UINavigationController(rootViewController: LogInViewController())
        
        feedNavigationController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "newspaper.circle"), tag: 0)
        loginNavigationController.tabBarItem = UITabBarItem(title: "Person", image: UIImage(systemName: "person.circle.fill"), tag: 1)
        
        mainTabBarController.setViewControllers([feedNavigationController, loginNavigationController], animated: false)
        return mainTabBarController
    }
}
