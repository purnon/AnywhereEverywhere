//
//  DriverHomeViewController.swift
//  AnywhereEverywhere
//
//  Created by ALAM on 5/28/18.
//  Copyright © 2018 App AE. All rights reserved.
//

import UIKit
//import MapKit
import GoogleMaps

class DriverHomeViewController: UIViewController, GMSMapViewDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    //@IBOutlet weak var mainMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.mapView.isMyLocationEnabled=true
        //self.mapView.settings.compassButton=true
        //self.mapView.delegate = self
        
        
        let camera = GMSCameraPosition.camera(withLatitude: 23.791630, longitude: 90.401872, zoom: 17.0)
        self.mapView.camera=camera
        
        
        // Creates a marker in the center of the map.
        let initialLocation = CLLocationCoordinate2DMake(23.791630, 90.401872)
        let marker = GMSMarker(position: initialLocation)
        marker.position = CLLocationCoordinate2D(latitude: 23.791630, longitude: 90.401872)
        marker.title = "Banani Road-6"
        marker.snippet = "Dhaka"
        marker.map = mapView
 
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
