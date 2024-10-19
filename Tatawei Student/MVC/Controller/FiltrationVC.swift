//
//  FiltrationVC.swift
//  Tatawei Student
//
//  Created by omar alzhrani on 16/04/1446 AH.
//

import UIKit

class FiltrationVC: UIViewController, Storyboarded {
    
    //MARK: - Varibales
    
    var coordinator: MainCoordinator?
    
    var interestsType: [InterestCategories] = [.All, .Tourism, .Technical, .Sports, .Social, .Healthy, .Financial, .Environmental, .Cultural, .Arts]
    let cities: [Cities] = [.MyLocation, .All, .Riyadh, .Jeddah, .Macca, .Madenah, .Taif, .Dammam, .Abha]
    
    var selectedInterestsTypeIndexPath: IndexPath?
    var selectedCityIndexPath: IndexPath?
    
    
    //MARK: - IBOutleats
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    //MARK: - IBAcitions
    @IBAction func didPressedCancel(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func didPressedFilter(_ sender: UIButton) {
        
    }
    
    
    //MARK: - Functions

}

extension FiltrationVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
       func numberOfSections(in collectionView: UICollectionView) -> Int {
           return 2
       }
       
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return section == 0 ? interestsType.count : cities.count
       }
       
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FiltrationCell", for: indexPath) as! FiltrationCell
        collectionView.semanticContentAttribute = .forceRightToLeft
        if indexPath.section == 0 {
            cell.config(type: interestsType[indexPath.row].rawValue, color: .systemGray5)
        } else {
            cell.config(type: cities[indexPath.row].rawValue, color: .systemGray5)
        }
        if (indexPath.section == 0 && indexPath == selectedInterestsTypeIndexPath) {
            cell.config(type: interestsType[indexPath.row].rawValue, color: .standr)
        } else if (indexPath.section == 1 && indexPath == selectedCityIndexPath) {
            cell.config(type: cities[indexPath.row].rawValue, color: .standr)
        } else {
            if indexPath.section == 0 {
                cell.config(type: interestsType[indexPath.row].rawValue, color: .systemGray5)
            } else {
                cell.config(type: cities[indexPath.row].rawValue, color: .systemGray5)
            }
        }
        
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Handle selection in "المجالات" (Fields) section
        if indexPath.section == 0 {
            if let selectedIndex = selectedInterestsTypeIndexPath, selectedIndex == indexPath {
                // Deselect if the same cell is clicked
                selectedInterestsTypeIndexPath = nil
            } else {
                // Update the selected index and reload previous and new cells
                let previousIndexPath = selectedInterestsTypeIndexPath
                selectedInterestsTypeIndexPath = indexPath
                if let previous = previousIndexPath {
                    collectionView.reloadItems(at: [previous])
                }
            }
            collectionView.reloadItems(at: [indexPath])
            
        // Handle selection in "المدينة" (City) section
        } else if indexPath.section == 1 {
            if let selectedIndex = selectedCityIndexPath, selectedIndex == indexPath {
                // Deselect if the same cell is clicked
                selectedCityIndexPath = nil
            } else {
                // Update the selected index and reload previous and new cells
                let previousIndexPath = selectedCityIndexPath
                selectedCityIndexPath = indexPath
                if let previous = previousIndexPath {
                    collectionView.reloadItems(at: [previous])
                }
            }
            collectionView.reloadItems(at: [indexPath])
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
           if kind == UICollectionView.elementKindSectionHeader {
               let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FiltrationHeaderView", for: indexPath) as! FiltrationHeaderView
               
               if indexPath.section == 0 {
                   headerView.titleLabel.text = "المجالات"
               } else {
                   headerView.titleLabel.text = "المدينة"
               }
               return headerView
           }
           return UICollectionReusableView()
       }

}


