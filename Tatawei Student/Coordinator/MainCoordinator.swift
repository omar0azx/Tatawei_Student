//
//  MainCoordinator.swift
//  Tatawei Student
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
    
    func viewQuestionsVC() {
        let vc = QuestionsVC.instantiate()
        vc.coordinator = self
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
    
    func viewIntroChatBotVC() {
        let vc = IntroChatBotVC.instantiate()
        vc.coordinator = self
        vc.modalPresentationStyle = .fullScreen
        self.navigationController.present(vc, animated: true)
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

    func viewFiltrationVC(data: DataFiltrationDelegate, interest: InterestCategories, city: Cities) {
        let vc = FiltrationVC.instantiate()
        vc.coordinator = self
        vc.delegate = data
        vc.interest = interest
        vc.city = city
        vc.modalPresentationStyle = .fullScreen
        navigationController.present(vc, animated: true)
    }
    
    func viewOpportunityVC(opportunity: Opportunity) {
        let vc = OpportunityVC.instantiate()
        vc.coordinator = self
        vc.opportunity = opportunity
        vc.modalPresentationStyle = .fullScreen
        navigationController.present(vc, animated: true)
    }
    
    func viewOrganizationVC(organizationID: String) {
        let vc = OrganizationVC.instantiate()
        vc.coordinator = self
        vc.organizationID = organizationID
        vc.modalPresentationStyle = .fullScreen
        // Present the MapVC modally from the currently presented view controller
        if let topViewController = navigationController.presentedViewController {
            topViewController.present(vc, animated: true, completion: nil)
        } else {
            navigationController.present(vc, animated: true, completion: nil)
        }
    }
    
    func viewAcceptanceApplyVC() {
        let vc = AcceptanceApplyVC.instantiate()
        vc.coordinator = self
        vc.modalPresentationStyle = .fullScreen
        // Present the MapVC modally from the currently presented view controller
        if let topViewController = navigationController.presentedViewController {
            topViewController.present(vc, animated: true, completion: nil)
        } else {
            navigationController.present(vc, animated: true, completion: nil)
        }
    }
    
    func viewStandardAcceptanceVC() {
        let vc = StandardAcceptanceVC.instantiate()
        vc.coordinator = self
        vc.modalPresentationStyle = .fullScreen
        // Present the MapVC modally from the currently presented view controller
        if let topViewController = navigationController.presentedViewController?.presentedViewController {
            topViewController.present(vc, animated: true, completion: nil)
        } else {
            navigationController.present(vc, animated: true, completion: nil)
        }
    }
    
    func viewPreviousOpportunitiesVC(opportunities: [Opportunity]) {
        let vc = PreviousOpportunitiesVC.instantiate()
        vc.coordinator = self
        vc.arrOppt = opportunities
        vc.modalPresentationStyle = .fullScreen
        self.navigationController.present(vc, animated: true)
    }

    func viewAboutVC() {
        let vc = AboutVC.instantiate()
        vc.coordinator = self
        self.navigationController.present(vc, animated: true)
    }
    
    func viewQRCodeVC() {
        let vc = QRCodeVC.instantiate()
        vc.coordinator = self
        vc.modalPresentationStyle = .overFullScreen
        self.navigationController.present(vc, animated: true)
    }

    func viewRatingVC(opportunity: Opportunity) {
        let vc = RatingVC.instantiate()
        vc.coordinator = self
        vc.opportunity = opportunity
        vc.modalPresentationStyle = .overFullScreen
        self.navigationController.present(vc, animated: true)
    }
}

