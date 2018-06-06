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

class DriverHomeViewController: UIViewController, CLLocationManagerDelegate {

    //I am checking here some code from
    //https://medium.freecodecamp.org/how-you-can-use-the-google-maps-sdk-with-ios-using-swift-4-a9bba26d9c4d
    
    
    @IBOutlet fileprivate weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let camera = GMSCameraPosition.camera(withLatitude: 37.36, longitude: -122.0, zoom: 17.0)
        mapView.camera = camera
        showMarker(position: camera.target)
        
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        /*
        UIApplication.shared.openURL(URL(string:"https://www.google.com/maps/@42.585444,13.007813,6z")!)

        
        
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.openURL(URL(string:
                "comgooglemapsurl://?center=40.765819,-73.975866&zoom=14&views=traffic")!)
        } else {
           print("Can't use comgooglemaps://");
        }
        */
        
    }
    
    func showMarker(position: CLLocationCoordinate2D){
        let marker = GMSMarker()
        marker.position = position
        marker.icon = GMSMarker.markerImage(with: .black)
        marker.isFlat = true
        marker.title = "Palo Alto"
        marker.snippet = "San Francisco"
        marker.map = mapView
    }
    
    
    @IBAction func btnONtest(_ sender: Any) {
        
        let primaryContactFullAddress = "M-45 - Abu Dhabi"
        let testURL: NSURL = NSURL(string: "comgooglemaps-x-callback://")!
        if UIApplication.shared.canOpenURL(testURL as URL) {
            
        if let address = primaryContactFullAddress.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            
            if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
                UIApplication.shared.openURL(URL(string:
                    "comgooglemapsurl://?center=40.765819,-73.975866&zoom=14&views=traffic")!)
            } else {
                print("Can't use comgooglemaps://");
            }
            
            /* ====================== this part working ok with google navigation
            let directionsRequest: String = "comgooglemaps-x-callback://" + "?daddr=\(address)" + "&x-success=sourceapp://?resume=true&x-source=AirApp"
                //let directionsURL: NSURL = NSURL(string: directionsRequest)!
                UIApplication.shared.openURL(URL(string: directionsRequest)!)
            } else {
                NSLog("Can't use comgooglemaps-x-callback:// on this device.")
             ====================== this part working ok with google navigation
            */ 
 
            }
 
        
        }
    
    }
    
    
    
    
    
    
    // THE COMMENTED CODE START HERE - CHECKING FOR GOOGLE MAPS
    /*
    
    @IBOutlet weak var mapView: GMSMapView!
    
    let locationManager = CLLocationManager()
    var currentLocation = CLLocation(latitude: 23, longitude: 90)
    var lat = Double(0)
    var lng = Double(0)
    var marker = GMSMarker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 17.0)
        self.mapView.camera=camera
        //mapView = GMSMapView.map(withFrame: self.view.bounds, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        
        lat = -33.86
        lng = 151.20
        let currentLocation = CLLocationCoordinate2DMake(lat, lng)
        marker = GMSMarker(position: currentLocation)
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        marker.title = "Your Current Location"
        marker.snippet = "Your City"
        marker.map = mapView
        
        
        locationManager.delegate=self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    @IBAction func btnONtest(_ sender: Any) {
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.openURL(URL(string:
                "comgooglemaps://?center=40.765819,-73.975866&zoom=14&views=traffic")!)
        } else {
            print("Can't use comgooglemaps://");
        }
        
    }
    
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
        let currentLocation = CLLocationCoordinate2DMake(lat, lng)
        marker = GMSMarker(position: currentLocation)
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        marker.title = "Your current location"
        marker.snippet = "Your City"
        marker.map = mapView
        
        //open(scheme: "https://www.google.com")
        
        
    }
    
 
    func open(scheme: String) {
        if let url = URL(string: scheme) {
            if #available(iOS 10, *) { // For ios 10 and greater
                UIApplication.shared.open(url, options: [:],
                                          completionHandler: {
                                            (success) in
                                            print("Open \(scheme): \(success)")
                })
            } else { // for below ios 10.
                let success = UIApplication.shared.openURL(url)
                print("Open \(scheme): \(success)")
            }
        }
    }
    
    
    
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
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    
    
    // THIS IS END OF COMMENTED CODE - CHECKING FOR GOOGLE MAPS 0N 05 Jun 2018
 
 */
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}



