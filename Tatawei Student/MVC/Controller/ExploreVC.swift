//
//  ExploreVC.swift
//  Tatawei Student
//
//  Created by omar alzhrani on 18/03/1446 AH.
//

import UIKit

class ExploreVC: UIViewController, Storyboarded {
    
    
    //MARK: - Varibales
    
    var coordinator: MainCoordinator?
    
    
    
    //MARK: - IBOutleats
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
    }
    
    
    //MARK: - IBAcitions
    
    
    //MARK: - Functions
    
    
}

extension ExploreVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreOpportunitiesCell", for: indexPath) as! ExploreOpportunitiesCell
//        cell.configOpportunity(backgroundColor: <#T##UIColor#>, opportunityImage: <#T##UIImage#>, opportunityName: <#T##String#>, opportunityTime: <#T##String#>, opportunityHours: <#T##Int#>, opportunityCity: <#T##String#>, organizationImage: <#T##UIImage#>)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                let collectionWidth = collectionView.bounds.width
            
            if collectionWidth / 2 < 300 {
                return CGSize(width: view.frame.width / 2.25, height: view.frame.height * 0.29)
            } else {
                return CGSize(width: view.frame.width / 3.25, height: view.frame.height * 0.39)
            }
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
                return 2
            }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                return 2
            }
    
}
