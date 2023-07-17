//
//  MainTabBarController.swift
//  MyHabits
//
//  Created by Liz-Mary on 17.07.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().tintColor = UIColor(red: 161/255, green: 22/255, blue: 204/255, alpha: 1.0)
        creatTabBarControllers()
    }
    
    private func creatTabBarControllers() {
        viewControllers = [generateViewController(rootViewController: HabitsViewController(), image: UIImage(systemName: "list.star") ?? UIImage(), title: "Привычки"), generateViewController(rootViewController: InfoViewController(), image: UIImage(systemName: "info.circle.fill") ?? UIImage(), title: "Информация")]
    }
    
    private func generateViewController(rootViewController: UIViewController, image: UIImage, title: String) -> UIViewController {
        
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        rootViewController.navigationItem.title = title
        //navigationVC.navigationBar.prefersLargeTitles = true
        
        return navigationVC
    }
    
}

