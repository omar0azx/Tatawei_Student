//
//  MainCoordinator.swift
//  AZAIM
//
//  Created by omar on 19/03/1445 AH.
//

import UIKit

final class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //MARK: Initial View Controller
    func start() {
        let navigationVC = NavigationVC.instantiate()
        
        
        let homeVC = HomeVC.instantiate()
        let exploreVC = ExploreVC.instantiate()
        let educationVC = EducationVC.instantiate()
        let profileVC = ProfileVC.instantiate()
        
        homeVC.coordinator = self
        exploreVC.coordinator = self
        educationVC.coordinator = self
        profileVC.coordinator = self
        navigationVC.coordinator = self
        
        navigationVC.viewControllers = [homeVC, exploreVC, educationVC, profileVC]
        
        self.navigationController.pushViewController(navigationVC, animated: false)
        
    }
    
}
