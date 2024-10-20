//
//  MainCoordinator.swift
//  AZAIM
//
//  Created by omar on 19/03/1445 AH.
//

import UIKit
import Firebase
import FirebaseAuth

final class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //MARK: Initial View Controller
    func start() {
        autoLogin()
    }
    
    func autoLogin() {
        
        if AuthService.shared.checkCurrentUserStatus() ||
        userDefaults.object(forKey: kCURRENTUSER) != nil {
            viewNavigationVC()
        } else {
            viewLoginVC()
        }
    }
    
    func viewRegisterVC() {
        let vc = StudentsAccountVC.instantiate()
        vc.coordinator = self
        vc.mode = .register
        vc.modalPresentationStyle = .fullScreen
        navigationController.present(vc, animated: true)
    }
    
    func viewEditProfileVC() {
        let vc = StudentsAccountVC.instantiate()
        vc.coordinator = self
        vc.mode = .editProfile
        vc.modalPresentationStyle = .fullScreen
        navigationController.present(vc, animated: true)
    }
    
    func viewLoginVC() {
        let vc = LoginVC.instantiate()
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: false)
    }
    
    func viewWebVC(url: String) {
        let vc = WebVC.instantiate()
        vc.coordinator = self
        vc.webUrl = url
        vc.modalPresentationStyle = .fullScreen
        navigationController.present(vc, animated: true)
    }
    
    func viewNavigationVC() {
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

    func viewFiltrationVC() {
        let vc = FiltrationVC.instantiate()
        vc.coordinator = self
        vc.modalPresentationStyle = .fullScreen
        navigationController.present(vc, animated: true)
    }
    
    func viewOpportunityVC() {
        let vc = OpportunityVC.instantiate()
        vc.coordinator = self
        vc.modalPresentationStyle = .fullScreen
        navigationController.present(vc, animated: true)
    }
    
}

