//
//  ClientLocationVC.swift
//  Store
//
//  Created by Mohamed on 8/20/20.
//  Copyright © 2020 MohamedHamid. All rights reserved.
//

import UIKit
import MapKit

class ClientLocationVC: UIViewController {
    
    // pass data from OrderVC
    var lat = ""
    var lon = ""
    
    // Outlet
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        location()
    }
    
    @IBAction func popButton(_ sender: Any) {
        popVC()
    }
    
    func location () {
        let latitude: CLLocationDegrees = Double(lat)!
        let longitude: CLLocationDegrees = Double(lon)!
        let regionDistance:CLLocationDistance = 200
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        mapView.setRegion(regionSpan, animated: true)
    }
    
}
