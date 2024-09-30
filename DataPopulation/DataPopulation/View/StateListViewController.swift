//
//  StateListViewController.swift
//  DataPopulation
//
//  Created by Valter Louro on 30/09/2024.
//

import Foundation
import UIKit

class StateListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setupNavigationBarLayout()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "State List"
    }
    
    //MARK: SETUP NAVIGATION BAR LAYOUT
    func setupNavigationBarLayout() {
        navigationController?.appearanceNavigation()
    }
}
