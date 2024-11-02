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
    func didSelectData(address: String, latitude: Double, longitude: Double)
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
        setupLocationManager()
        setupMapView()
        if let location = lastKnownLocation {
            addCircleToMap(at: location, radius: 10)
        }
    }
    
    // MARK: - Setup Functions
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = kCLDistanceFilterNone
    }
    
    private func setupMapView() {
        let defaultCameraPosition = GMSCameraPosition.camera(withLatitude: 37.7749, longitude: -122.4194, zoom: 10.0)
        mapView.camera = defaultCameraPosition
        mapView.isMyLocationEnabled = true
    }
    
    // MARK: - IBActions
    
    @IBAction func pressLocate(_ sender: UIButton) {
        guard let location = locationManager.location else {
            print("Current location is not available.")
            return
        }
        reverseGeocodeLocation(location)
    }
    
    // MARK: - Location Handling
    private func reverseGeocodeLocation(_ location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location) { [weak self] placemarks, error in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                return
            }
            guard let placemark = placemarks?.first else {
                print("No placemarks found.")
                return
            }
            let address = self?.formattedAddress(from: placemark)
            let coordinates = location.coordinate // Get the coordinates from the location
            
            // Pass both address and coordinates to the delegate
            self?.delegate?.didSelectData(address: address ?? "Unknown location", latitude: coordinates.latitude, longitude: coordinates.longitude)
            self?.dismiss(animated: true)
        }
    }
    
    private func formattedAddress(from placemark: CLPlacemark) -> String {
        let neighborhood = placemark.subLocality ?? "Unknown neighborhood"
        let city = placemark.locality ?? "Unknown city"
        return "\(neighborhood), \(city)"
    }
    
    private func addCircleToMap(at location: CLLocation, radius: Double) {
        mapView.clear() // Clear the map to prevent overlapping circles
        let circle = GMSCircle(position: location.coordinate, radius: radius) // radius in meters
        circle.fillColor = .standr.withAlphaComponent(0.3)
        circle.strokeColor = .standr
        circle.strokeWidth = 2.0
        circle.map = mapView
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        lastKnownLocation = location
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 15.0)
        mapView.animate(to: camera)
        
        // Draw an initial circle with a default radius
        addCircleToMap(at: location, radius: 5000) // Default to 5 km
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
}
