//
//  ContainerVC.swift
//  AZAIM
//
//  Created by omar on 20/03/1445 AH.
//

import UIKit

class ContainerVC: UIViewController {

    var container = UIView(frame: .zero)
    var viewControllers = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        container.frame = view.bounds
        view.insertSubview(container, at: 0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addSubViewControllers()
    }
    
    func addSubViewControllers() {
        for viewController in viewControllers {
            viewController.view.frame = view.bounds
            container.addSubview(viewController.view)
            addChild(viewController)
            viewController.didMove(toParent: self)
        }
    }

}