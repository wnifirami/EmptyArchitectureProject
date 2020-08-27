//
//  WelcomeCoordinator.swift
//  EmptyArchitectureProject
//
//  Created by Rami Ounifi on 6/19/20.
//  Copyright © 2020 Yellow. All rights reserved.
//

import Foundation
import RxSwift
// MARK: - Properties
class WelcomeCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    let welcomeController = WelcomeViewController.initFromNib()
    let viewModel = WelcomeViewModel(testService: TestServices())
    private let disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    // MARK: - LifeCycle
    func start()  {
        
        navigationController.navigationBar.isHidden = true
        showWelcomeController()
        
    }
    
    // MARK: - Members
    func showWelcomeController() {
        
        welcomeController.viewModel = viewModel
        self.navigationController.setViewControllers([self.welcomeController],animated: true)
        
        
    }
    
    
    
    func coordinatorDidExit(coordinator: Coordinator) { }
}
