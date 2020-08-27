//
//  AppCoordinator.swift
//  EmptyArchitectureProject
//
//  Created by Rami Ounifi on 6/19/20.
//  Copyright © 2020 Yellow. All rights reserved.
//

import Foundation
import UIKit
class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var window: UIWindow?
    // MARK: - Initializers
    init(navigationController: UINavigationController ) {
        self.navigationController = navigationController
    }
    
    // MARK: - LifeCycle
    func start() {
        showSignInCoordinator()
    }
    
    // MARK: - Members
    
    func showSignInCoordinator(){
        let signInCoordinator = WelcomeCoordinator(navigationController: self.navigationController)
        signInCoordinator.parentCoordinator = self
        childCoordinators.append(signInCoordinator)
        signInCoordinator.start()
    }
 
    
    
    func coordinatorDidExit(coordinator: Coordinator) { }
}

