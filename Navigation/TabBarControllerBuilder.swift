

import UIKit

class TabBarControllerBuilder {
    static func build() -> UITabBarController {
        let mainTabBarController = UITabBarController()
        let feedNavigationController = UINavigationController(rootViewController: FeedViewController())
        //let avatarNavigationController = UINavigationController(rootViewController: AvatarGestureViewController())
        let loginNavigationController = UINavigationController(rootViewController: LogInViewController())
        
        feedNavigationController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "newspaper.circle"), tag: 0)
        loginNavigationController.tabBarItem = UITabBarItem(title: "Person", image: UIImage(systemName: "person.circle.fill"), tag: 1)
        //avatarNavigationController.tabBarItem = UITabBarItem(title: "Avatar", image: UIImage(systemName: "pawprint"), tag: 2)
        
        mainTabBarController.setViewControllers([feedNavigationController, loginNavigationController/*, avatarNavigationController*/], animated: false)
        return mainTabBarController
    }
}
