//
//  ViewController.swift
//  DataPopulation
//
//  Created by Valter Louro on 30/09/2024.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .customTabBarColor
        self.tabBar.barTintColor = .customTabBarColor
        self.tabBar.tintColor = .customTabBarTintColor
        self.tabBar.unselectedItemTintColor = .customTabBarUnselectedItem
        self.navigationController?.navigationBar.backgroundColor = .customTabBarColor
        self.navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.customBarTintColor ?? UIColor.white]
        self.setupTabControllers()
    }

    func setupTabControllers(){
        // Set up the Product List View Controller
        let nationViewController = UINavigationController(rootViewController: NationListViewController())
        let stateViewController = UINavigationController(rootViewController: StateListViewController())
        
        //Icons
        let nationIcon = UITabBarItem(title: "Nation", image: UIImage(named: "countryFlag"), selectedImage: UIImage(named: "countryFlag"))
        let stateIcon = UITabBarItem(title: "State", image: UIImage(named: "cityCouncil"), selectedImage: UIImage(named: "cityCouncil"))
        nationViewController.tabBarItem = nationIcon
        stateViewController.tabBarItem = stateIcon
        
        let controllers = [nationViewController, stateViewController]
        self.viewControllers = controllers
    }

}

extension ViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true;
    }
}

