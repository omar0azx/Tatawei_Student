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
        
        let registerVC = RegisterVC.instantiate()
        let loginVC = LoginVC.instantiate()
        let homeVC = HomeVC.instantiate()
        let exploreVC = ExploreVC.instantiate()
        let educationVC = EducationVC.instantiate()
        let profileVC = ProfileVC.instantiate()
        
        registerVC.coordinator = self
        loginVC.coordinator = self
        homeVC.coordinator = self
        exploreVC.coordinator = self
        educationVC.coordinator = self
        profileVC.coordinator = self
        navigationVC.coordinator = self
        
        navigationVC.viewControllers = [homeVC, exploreVC, educationVC, profileVC]
        
        self.navigationController.pushViewController(loginVC, animated: false)
    }
    
    func viewRegisterVC() {
        let vc = RegisterVC.instantiate()
        vc.coordinator = self
        vc.modalPresentationStyle = .fullScreen
        navigationController.present(vc, animated: true)
    }
    
    func viewNavigationVC() {
        let navigationVC = NavigationVC.instantiate()
        
        let registerVC = RegisterVC.instantiate()
        let loginVC = LoginVC.instantiate()
        let homeVC = HomeVC.instantiate()
        let exploreVC = ExploreVC.instantiate()
        let educationVC = EducationVC.instantiate()
        let profileVC = ProfileVC.instantiate()
        
        registerVC.coordinator = self
        loginVC.coordinator = self
        homeVC.coordinator = self
        exploreVC.coordinator = self
        educationVC.coordinator = self
        profileVC.coordinator = self
        navigationVC.coordinator = self
        
        navigationVC.viewControllers = [homeVC, exploreVC, educationVC, profileVC]
        
        self.navigationController.pushViewController(navigationVC, animated: false)
    }
    
    func viewMapVC(animation: Bool) {
        let vc = MapVC.instantiate()
        vc.coordinator = self
        vc.modalPresentationStyle = .fullScreen
        // Present the MapVC modally from the currently presented view controller
        if let topViewController = navigationController.presentedViewController {
            topViewController.present(vc, animated: animation, completion: nil)
        } else {
            navigationController.present(vc, animated: animation, completion: nil)
        }
    }
    
    func viewforgetPasswordVC(animation: Bool) {
        let vc = ForgetPasswordVC.instantiate()
        vc.coordinator = self
        navigationController.present(vc, animated: true)
    }

}
