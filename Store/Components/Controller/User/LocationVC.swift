//
//  LocationVC.swift
//  Store
//
//  Created by Mohamed on 8/19/20.
//  Copyright © 2020 MohamedHamid. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol SendAddress {
    func adress (name:String , lat:String , lon:String)
}

class LocationVC: UIViewController {
    
    @IBOutlet var adressL: UILabel!
    @IBOutlet var mapView: MKMapView!
    let regionInMeters : Double = 100
    let locationManager = CLLocationManager()
    
    var previousLocation : CLLocation!
    
    var delegate : SendAddress?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        checkLocationAutraization()
        
    }
    
    //Send Data Back
    @IBAction func popButton(_ sender: Any) {
        popVC()
    }
    
    func sendaddress (name:String , lat:String , lon:String){
        delegate?.adress(name: name, lat: lat , lon: lon)
    }
    
    func setupLocationManager () {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServiece () {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            // checkLocationServiece()
            checkLocationAutraization()
            
        }else{
            
        }
    }
    
    func centerViewUserLocation () {
        
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
            
        }
    }
    
    func checkLocationAutraization () {
        
        switch CLLocationManager.authorizationStatus() {
            
        case .authorizedWhenInUse :
            startTackingLocation()
            
        case .denied:
            //showalert
            break
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            //show alert
            break
            
        case .authorizedAlways:
            break
            
        @unknown default:
            print("Error Locations")
        }
        
    }
    
    
    func startTackingLocation () {
        
        mapView.showsUserLocation = true
        centerViewUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
        
    }
    
    
    func getCenterLocation (for mapView : MKMapView) -> CLLocation {
        
        let latitude = mapView.centerCoordinate.latitude
        let longtude = mapView.centerCoordinate.longitude
        
        return CLLocation (latitude: latitude, longitude: longtude)
    }
    
}


extension LocationVC:CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        checkLocationAutraization()
    }
    
}


extension LocationVC : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        let geocoder = CLGeocoder()
        
        guard let previousLocation = self.previousLocation else {return}
        guard center.distance(from: previousLocation) > 50 else {return}
        self.previousLocation = center
        
        geocoder.reverseGeocodeLocation(center) { [weak self](placemarks , error) in
            
            guard let self = self else {return}
            
            if let _ = error {
                // do any thing
                return
            }
            
            guard let placemark = placemarks?.first else {
                //do any thing
                return
            }
            
            let streetNumber = placemark.subThoroughfare ?? ""
            let streetName = placemark.thoroughfare ?? ""
            
            DispatchQueue.main.async {
                self.adressL.text = "\(streetNumber) \(streetName)"
                
                let lat = String(mapView.centerCoordinate.latitude)
                let lon = String(mapView.centerCoordinate.longitude)
                
                self.sendaddress(name: streetNumber+streetName , lat: lat , lon : lon)
            }
        }
    }
}

