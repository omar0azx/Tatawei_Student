//
//  ExploreVC.swift
//  Tatawei Student
//
//  Created by omar alzhrani on 18/03/1446 AH.
//

import UIKit
import CoreLocation

class ExploreVC: UIViewController, Storyboarded, DataFiltrationDelegate {
    
    
    //MARK: - Varibales
    
    var coordinator: MainCoordinator?
    
    var opportunities: [Opportunity] = []
    var searchedOpportunities = [Opportunity]()
    
    var interestFiltration: InterestCategories = .All
    var locationFiltration: Cities = .All
    
    var userLatitude: Double = 24.7136
    var userLongitude: Double = 46.6753
    
    var isLoading = false // To prevent multiple calls while loading
    var hasMoreData = true // To detect if all data has been loaded
    let limit = 5 // Number of items per batch
    
    
    //MARK: - IBOutleats
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        loadMoreOpportunities()
        searchedOpportunities = opportunities
        
        self.hideKeyboardWhenTappedAround()
    }
    
    
    @IBAction func searchOpportunityTF(_ sender: UITextField) {
        if let serchText = sender.text {
            searchedOpportunities = serchText.isEmpty ? opportunities : opportunities.filter{$0.name.lowercased().contains(serchText.lowercased())}
            collectionView.reloadData()
        }
    }
    
    //MARK: - IBAcitions
    
    @IBAction func openFilter(_ sender: UIButton) {
        coordinator?.viewFiltrationVC(data: self, interest: interestFiltration, city: locationFiltration)
    }
    
    func didSelectData(interest: InterestCategories, location: Cities) {
        interestFiltration = interest
        locationFiltration = location
        applyFilters()
    }
    
    func applyFilters() {
        DispatchQueue.main.async {
            if self.interestFiltration == .All && self.locationFiltration == .All {
                // No filters applied, show all opportunities
                self.searchedOpportunities = self.opportunities
            } else {
                // Apply interest, location, and distance filters
                if let student = Student.currentStudent {
                    self.userLatitude = student.latitude
                    self.userLongitude = student.longitude
                    let userLocation = CLLocation(latitude: self.userLatitude, longitude: self.userLongitude)
                    
                    self.searchedOpportunities = self.opportunities.filter { opportunity in
                        let matchesInterest = (self.interestFiltration == .All) || (opportunity.category == self.interestFiltration || student.interests.contains(opportunity.category))
                        
                        let matchesLocation: Bool
                        if self.locationFiltration == .MyLocation {
                            // Calculate distance to user location
                            let opportunityLocation = CLLocation(latitude: opportunity.latitude, longitude: opportunity.longitude)
                            let distance = userLocation.distance(from: opportunityLocation) // Distance in meters
                            matchesLocation = distance <= 16000 //16000 m -> 16 km
                        } else {
                            // Use the city filter for specified city matches
                            matchesLocation = (self.locationFiltration == .All) || (opportunity.city == self.locationFiltration)
                        }
                        
                        // Return true if both filters match
                        return matchesInterest && matchesLocation
                    }
                }
            }
            self.collectionView.reloadData()
        }
    }

    
    
    
    //MARK: - Functions
    
    func loadMoreOpportunities() {
            guard !isLoading && hasMoreData else { return } // Prevent multiple simultaneous calls
            isLoading = true
        OpportunityDataServices.shared.downloadOpportunitiesFromFirestore(limit: limit) { (newOpportunities, error) in
                if let error = error {
                    print("Error fetching opportunities: \(error.localizedDescription)")
                    return
                }
                guard let newOpportunities = newOpportunities else { return }
                // Check if no new opportunities were returned, meaning no more data to load
                if newOpportunities.isEmpty {
                    self.hasMoreData = false // No more data available
                } else {
                    // Append the new opportunities and reload the collection view
                    self.opportunities.append(contentsOf: newOpportunities)
                    DispatchQueue.main.async {
                        self.searchedOpportunities = self.opportunities
                        self.collectionView.reloadData()
                    }
                }

                self.isLoading = false
            }
        }
    
    
}

extension ExploreVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchedOpportunities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellColorAndIcon = Icon(index: searchedOpportunities[indexPath.row].iconNumber, categories: searchedOpportunities[indexPath.row].category).opportunityIcon
        var organizationImag: UIImage?
        StorageService.shared.downloadImage(from: "organisations_icons/\(searchedOpportunities[indexPath.row].organizationID).jpg") { imag, error in
            guard let image = imag else {return}
            organizationImag = image
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreOpportunitiesCell", for: indexPath) as! ExploreOpportunitiesCell
        cell.configOpportunity(backgroundColor: cellColorAndIcon.1, opportunityImage: cellColorAndIcon.0, opportunityName: searchedOpportunities[indexPath.row].name, opportunityTime: searchedOpportunities[indexPath.row].time, opportunityHours: searchedOpportunities[indexPath.row].hour, opportunityCity: searchedOpportunities[indexPath.row].city.rawValue, organizationImage: organizationImag ?? #imageLiteral(resourceName: "tatawei"))
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
        coordinator?.viewOpportunityVC(opportunity: searchedOpportunities[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - frameHeight {
            // User has scrolled to the bottom, load more opportunities
            if interestFiltration == .All && locationFiltration == .All {
                loadMoreOpportunities()
            }
        }
    }
    
}
