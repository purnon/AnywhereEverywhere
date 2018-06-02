//
//  DriverHomeViewController.swift
//  AnywhereEverywhere
//
//  Created by ALAM on 5/28/18.
//  Copyright © 2018 App AE. All rights reserved.
//

import UIKit
//import MapKit
import CoreLocation
import GoogleMaps

class DriverHomeViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    
    let locationManager=CLLocationManager()
    var currentLocation = CLLocation()
    var lat = Double(0)
    var lng = Double(0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate=self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestAlwaysAuthorization()
        locationManager.stopMonitoringSignificantLocationChanges()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        locationAuthStatus()
        
        
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: 17.0)
        self.mapView.camera=camera
        
        
        // Creates a marker in the center of the map.
        let initialLocation = CLLocationCoordinate2DMake(lat, lng)
        let marker = GMSMarker(position: initialLocation)
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        marker.title = "Your Current Location"
        marker.snippet = "-----------"
        marker.map = mapView
    }
    

    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            currentLocation=locationManager.location!
            lat = currentLocation.coordinate.latitude
            lng = currentLocation.coordinate.longitude
            
        } else {
            locationManager.requestAlwaysAuthorization()
            locationAuthStatus()
        }
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
