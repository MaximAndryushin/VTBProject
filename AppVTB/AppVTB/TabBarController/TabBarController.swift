//
//  TabBar.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 11.08.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {
    
    
    //MARK: - Constants
    
    private enum Locals {
        static let historyScreen = "History"
        static let historyImage = "history"
        static let favoritesScreen = "Favorites"
        static let favoritesImage = "favorite"
        static let checkImage = "check"
        static let checkScreen = "Check"
        static let position = ["History" : 0, "Check" : 1, "Favorites": 2]
    }
    
    
    //MARK: - Initializers
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configureTabBarItems()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureTabBarItems()
    }
    
    
    //MARK: - Life Cycle
    
    private func configureTabBarItems() {
        
        var firstViewController: UIViewController = HistoryViewController()
        configureController(viewController: &firstViewController, image: UIImage(named: Locals.historyImage)!, tag: Locals.position[Locals.historyScreen]!, title: Locals.historyScreen)

        var secondViewController = CheckAssembly.assembly()
        configureController(viewController: &secondViewController, image: UIImage(named: Locals.checkImage)!, tag: Locals.position[Locals.checkScreen]!, title: Locals.checkScreen)
        
        var thirdViewController = FavoritesAssembly.assembly()
        configureController(viewController: &thirdViewController, image: UIImage(named: Locals.favoritesImage)!, tag: Locals.position[Locals.favoritesScreen]!, title: Locals.favoritesScreen)

        let tabBarList = [firstViewController, secondViewController, thirdViewController]

        self.viewControllers = tabBarList
    }
    
    private func configureController(viewController: inout UIViewController, image: UIImage, tag: Int, title: String) {
        let tabBarItem = UITabBarItem()
        tabBarItem.image = image
        tabBarItem.tag = tag
        tabBarItem.title = title
        viewController.tabBarItem = tabBarItem
    }
    
}
