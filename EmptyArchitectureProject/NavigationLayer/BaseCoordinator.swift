//
//  BaseCoordinator.swift
//  EmptyArchitectureProject
//
//  Created by Rami Ounifi on 6/19/20.
//  Copyright © 2020 Yellow. All rights reserved.
//

import Foundation
import UIKit


protocol Coordinator: AnyObject{
    
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
    func coordinatorDidExit(coordinator: Coordinator)
}

extension Coordinator {
    func coordinatorDidExit(_ coordinator: Coordinator) {
        guard let index = self.childCoordinators.firstIndex(where: { $0 === coordinator }) else { return }
        self.childCoordinators.remove(at: index)
    }
}
