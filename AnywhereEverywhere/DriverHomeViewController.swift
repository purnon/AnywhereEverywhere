//
//  DriverHomeViewController.swift
//  AnywhereEverywhere
//
//  Created by ALAM on 5/28/18.
//  Copyright © 2018 App AE. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import GoogleMaps

class DriverHomeViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    
    var mapView1 = GMSMapView()
    
    let locationManager = CLLocationManager()
    var currentLocation = CLLocation(latitude: 23, longitude: 90)
    var lat = Double(0)
    var lng = Double(0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        self.mapView.camera=camera
        //mapView = GMSMapView.map(withFrame: self.view.bounds, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        
        //view = mapView
        
        let initialLocation = CLLocationCoordinate2DMake(lat, lng)
        let marker = GMSMarker(position: initialLocation)
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        marker.title = "Your Current Location"
        marker.snippet = "-----------"
        marker.map = mapView1
        
        /*
        locationManager.delegate=self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        */
        
    }
    
    
    
    /* ===================
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        //let center = location.coordinate
        //let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        //let region = MKCoordinateRegion(center: center, span: span)
        lat = location.coordinate.latitude
        lng = location.coordinate.longitude
     
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: 17.0)
        self.mapView.camera=camera
        // Creates a marker in the center of the map.
        let initialLocation = CLLocationCoordinate2DMake(lat, lng)
        let marker = GMSMarker(position: initialLocation)
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        marker.title = "Your Current Location"
        marker.snippet = "-----------"
        marker.map = mapView
        
        mapView.settings.myLocationButton = true
    }

    */
 
 
 
 
    /*
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            currentLocation = locationManager.location!
            lat = currentLocation.coordinate.latitude
            lng = currentLocation.coordinate.longitude
            
        } else {
            locationManager.requestAlwaysAuthorization()
            locationAuthStatus()
        }
        
    }
    */
    
    
    
    
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
