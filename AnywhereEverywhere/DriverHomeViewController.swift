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

class DriverHomeViewController: UIViewController {

    //@IBOutlet weak var mainMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //GMSServices.provideAPIKey("AIzaSyBJJicsiZ9K36T2EzITdQqR3eeDsq9vnAU")
        //GMSPlacesClient.provideAPIKey("AIzaSyBJJicsiZ9K36T2EzITdQqR3eeDsq9vnAU")
        //51.888966, -0.371633
        let camera = GMSCameraPosition.camera(withLatitude: 51.888966, longitude: 0.371633, zoom: 13.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 51.888966, longitude: 0.371633)
        marker.title = "Wigmore Ln, Luton"
        marker.snippet = "London, UK"
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
