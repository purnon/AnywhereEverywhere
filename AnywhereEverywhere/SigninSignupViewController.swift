//
//  SigninSignupViewController.swift
//  AnywhereEverywhere
//
//  Created by Kazi on 5/27/18.
//  Copyright © 2018 App AE. All rights reserved.
//

import UIKit
import CoreLocation
import NVActivityIndicatorView

class SigninSignupViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate, NVActivityIndicatorViewable
{
    
    //@IBOutlet weak var btnEmailID: UIButton! ===== this button is no more in use
    var ttoken = "NONE"
    var emailStr = "username as email"
    var pwdStr = "password string"
    var flagForNextViewController = "flag for next view"
    var cLat = Double()
    var cLon = Double()
    var locationManager:CLLocationManager = CLLocationManager()
    var cLoc = CLLocation()
    
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

      
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        self.txtEmail.text = userID.user.email
        self.txtPassword.text = userID.user.password
        
        userID.user.deviceToken = "123568987642123456786421234"//UserDefaults.standard.string(forKey: "deviceToken")
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    
    // MARK: TEXT FIELD DELEGATES
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         self.view.endEditing(true)
        return true
    }
   
    // MARK: LOCATION MANAGER
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        guard let location = manager.location else { return }

        cLat = location.coordinate.latitude
        cLon = location.coordinate.longitude
        print(cLat , cLon)
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: SIGN IN
    @IBAction func btnSignIn(_ sender: Any)
    {
        self.view.endEditing(true)
        if currentReachabilityStatus != .notReachable
        {
            callWebserviceToLoginTheDriver()
        }
        else
        {
            showAlert.myController(message: "Internet not available. Please connect to internet and try again!" , view: self, title: "Error!" )
        }
    }
    
    func callWebserviceToLoginTheDriver()
    {
        DispatchQueue.main.async
            {
                self.startAnimating(CGSize(width: 100, height:100), message: "", type: NVActivityIndicatorType.ballRotateChase)
        }
        
        self.emailStr = "\(txtEmail.text ?? "0")"
        self.pwdStr = "\(txtPassword.text ?? "0")"
        
        let urlString = "\(Constants.BASE_URL)\(Constants.LOGIN)"
        guard let requestUrl = URL(string:urlString) else { return }
        let devid = UIDevice.current.identifierForVendor!.uuidString
        let parameters = "email=\(self.emailStr)&password=\(self.pwdStr)&device_token=\(userID.user.deviceToken!)&device_id=\(devid)&device_type=ios"
        print(parameters)
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-unlencoded;charset=utf-8", forHTTPHeaderField: "Content-Length")
        request.httpBody = parameters.data(using: String.Encoding.utf8)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if response != nil {
                guard let data = data else { return }
                var json: NSDictionary?
                do {
                    DispatchQueue.main.async
                        {
                             self.stopAnimating()
                    }
                    json = try JSONSerialization.jsonObject(with: data) as? NSDictionary
                    print(json)
                    let arrayOfKeys = json?.allKeys as! NSArray
                    print(arrayOfKeys)
                    DispatchQueue.main.async
                        {
                    if arrayOfKeys.contains("access_token")
                    {
                    self.ttoken = json?["access_token"]! as! String
                    }
                    else if arrayOfKeys.contains("error")
                    {
                        
                        showAlert.myController(message: json?["error"]! as! String , view: self, title: "Error!" )
                        print("Invalid email or password !!!")
                        
                    }
                    else
                    {
                       showAlert.myController(message: "Please Try Again!" , view: self, title: "Error!" )
                    }
                    }
                }catch{
                    print("THIS IS THE JSON ERROR IN SIGN-IN SCREEN: \(error)")
                }
                
                DispatchQueue.main.async
                    {
                if self.ttoken != "NONE" {
                    self.ttoken = json?["access_token"]! as! String
                    UserDefaults.standard.set(self.emailStr, forKey: "email")
                    UserDefaults.standard.set(self.pwdStr, forKey: "password")
                    userID.user.ID = String(json?["id"]! as! Int)
                    userID.user.email = self.emailStr
                    userID.user.password = self.pwdStr
                    UserDefaults.standard.set(String(json?["id"]! as! Int), forKey: "userID")
                    UserDefaults.standard.synchronize()
                    self.flagForNextViewController = "DriverHome"
                    self.performSegue(withIdentifier: "SignInSegue", sender: nil)
                }
                else
                {
                    
                    showAlert.myController(message: "Invalid email or password !" , view: self, title: "Error!" )
                    print("Invalid email or password !!!")
                    
                }
                }
            }
            }.resume()
        
    }
    
   // MARK: SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if flagForNextViewController == "DriverHome" {
            let nextViewController = segue.destination as! DriverHomeViewController
            nextViewController.carryToken = self.ttoken
            nextViewController.carryLat = self.cLat
            nextViewController.carryLon = self.cLon
        }
    }
}
