//
//  MapVC.swift
//  Tatawei Student
//
//  Created by omar alzhrani on 27/03/1446 AH.
//

import UIKit
import GoogleMaps
import CoreLocation

protocol DataSelectionDelegate: AnyObject {
    func didSelectData(_ data: String)
}

class MapVC: UIViewController, Storyboarded, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    
    //MARK: - Varibales
    
    var coordinator: MainCoordinator?
    
    weak var delegate: DataSelectionDelegate?
    
    var locationManager = CLLocationManager()
    var geocoder = CLGeocoder()
    var lastKnownLocation: CLLocation?
    
    
    //MARK: - IBOutleats
    
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize Location Manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = kCLDistanceFilterNone
        
        let camera = GMSCameraPosition.camera(withLatitude: 37.7749, longitude: -122.4194, zoom: 10.0)
        mapView.camera = camera // Set the camera to the map view
        mapView.isMyLocationEnabled = true
        
    }
    
    
    //MARK: - IBAcitions
    
    @IBAction func pressLocate(_ sender: UIButton) {
        if let lastKnownLocation = locationManager.location {
               let geocoder = CLGeocoder() // Create an instance of CLGeocoder
               
               // Perform reverse geocoding
               geocoder.reverseGeocodeLocation(lastKnownLocation) { (placemarks, error) in
                   if let error = error {
                       print("Geocoding error: \(error.localizedDescription)")
                       return
                   }
                   
                   if let placemark = placemarks?.first {
                       // Extract relevant information from the placemark
                       let neighborhood = placemark.subLocality ?? "Unknown neighborhood"
                       let city = placemark.locality ?? "Unknown city"
                       let address = "\(neighborhood), \(city)"
                       
                       // Pass the address information to the coordinator
                       self.delegate?.didSelectData(address)
                       self.dismiss(animated: true)
                   } else {
                       print("No placemarks found.")
                   }
               }
           } else {
               print("Current location is not available.")
           }
    }
    
    
    //MARK: - Functions
    
    // Handle Location Updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            lastKnownLocation = location // Store the last known location
            let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 15.0)
            mapView?.animate(to: camera)
        }
    }
    
    // Handle Location Access Denied
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }

}
