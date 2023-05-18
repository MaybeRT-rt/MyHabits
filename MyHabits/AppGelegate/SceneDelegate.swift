//
//  SceneDelegate.swift
//  MyHabits
//
//  Created by Liz-Mary on 14.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        let habitsVC = HabitsViewController()
        let infoVC = InfoViewController()
        let window = UIWindow(windowScene: scene as! UIWindowScene)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [habitsVC, infoVC]
        
        window.rootViewController = createTabBar()
        window.makeKeyAndVisible()
        
        self.window = window
        
    }
    
    func creatHabits() -> UINavigationController {
        let habitsVC = HabitsViewController()
        habitsVC.tabBarItem = UITabBarItem(title: "Привычки", image: UIImage(systemName: "list.star"), tag: 0)
        
        return UINavigationController(rootViewController: habitsVC)
    }
    
    func creatInfo() -> UINavigationController {
        let infoVC = InfoViewController()
        infoVC.tabBarItem = UITabBarItem(title: "Информация", image: UIImage(systemName: "info.circle.fill"), tag: 1)
        
        return UINavigationController(rootViewController: infoVC)
    }
    
    private func createTabBar() ->  UITabBarController {
        
        let tbController = UITabBarController()
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().tintColor = UIColor(red: 161/255, green: 22/255, blue: 204/255, alpha: 1.0)
        tbController.viewControllers = [creatHabits(), creatInfo()]
        
        return tbController
    }
}

