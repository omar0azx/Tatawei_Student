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
    
    var opportunities: [Opportunity] = []
    var isLoading = false // To prevent multiple calls while loading
    var hasMoreData = true // To detect if all data has been loaded
    let limit = 5 // Number of items per batch
    
    
    //MARK: - IBOutleats
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        loadMoreOpportunities()
        
        self.hideKeyboardWhenTappedAround()
    }
    
    
    //MARK: - IBAcitions
    
    @IBAction func openFilter(_ sender: UIButton) {
        coordinator?.viewFiltrationVC()
    }
    
    //MARK: - Functions
    
    func loadMoreOpportunities() {
            guard !isLoading && hasMoreData else { return } // Prevent multiple simultaneous calls
            isLoading = true

        OpportunityDataServices.shared.downloadOpportunitiesFromFirestore(limit: limit) { [weak self] (newOpportunities, error) in
                if let error = error {
                    print("Error fetching opportunities: \(error.localizedDescription)")
                    return
                }

                guard let newOpportunities = newOpportunities else { return }

                // Check if no new opportunities were returned, meaning no more data to load
                if newOpportunities.isEmpty {
                    self?.hasMoreData = false // No more data available
                } else {
                    // Append the new opportunities and reload the collection view
                    self?.opportunities.append(contentsOf: newOpportunities)
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                }

                self?.isLoading = false
            }
        }
    
}

extension ExploreVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return opportunities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellColorAndIcon = Icon(index: opportunities[indexPath.row].iconNumber, categories: opportunities[indexPath.row].category).icons
        var organizationImag: UIImage?
        StorageService.shared.downloadImage(from: opportunities[indexPath.row].organizationImageLink) { imag, error in
            guard let image = imag else {return}
            organizationImag = image
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreOpportunitiesCell", for: indexPath) as! ExploreOpportunitiesCell
        cell.configOpportunity(backgroundColor: cellColorAndIcon.1, opportunityImage: cellColorAndIcon.0, opportunityName: opportunities[indexPath.row].name, opportunityTime: opportunities[indexPath.row].time, opportunityHours: opportunities[indexPath.row].hour, opportunityCity: opportunities[indexPath.row].city, organizationImage: organizationImag ?? #imageLiteral(resourceName: "P2.svg"))
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator?.viewOpportunityVC(opportunity: opportunities[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - frameHeight {
            // User has scrolled to the bottom, load more opportunities
            loadMoreOpportunities()
        }
    }
    
}
