//
//  MainTabBarController.swift
//  MusicApp
//
//  Created by Stanly Shiyanovskiy on 17.01.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public class MainTabBarController: UITabBarController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        let searchVC = generateViewController(rootViewController: UIViewController(), image: UIImage(systemName: "magnifyingglass"), title: "Search")
        
        let libraryVC = generateViewController(rootViewController: UIViewController(), image: UIImage(systemName: "music.note"), title: "Library")
        
        viewControllers = [searchVC,
                           libraryVC]
        
        tabBar.tintColor = #colorLiteral(red: 1, green: 0, blue: 0.3764705882, alpha: 1)
    }
    
    private func generateViewController(rootViewController: UIViewController, image: UIImage?, title: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        navigationVC.navigationBar.prefersLargeTitles = true
        
        return navigationVC
    }
}

