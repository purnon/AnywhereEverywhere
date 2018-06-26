//
//  SigninSignupViewController.swift
//  AnywhereEverywhere
//
//  Created by Kazi on 5/27/18.
//  Copyright © 2018 App AE. All rights reserved.
//

import UIKit
//import Foundation

class SigninSignupViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var btnEmailID: UIButton!
    var ttoken = "token"
    var emailStr = "username as email"
    var pwdStr = "password string"
    
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnEmailID.isHidden = true
        txtPassword.isSecureTextEntry = true
        txtPassword.delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSignIn(_ sender: Any) {
        
        self.emailStr = "\(txtEmail.text ?? "0")"
        self.pwdStr = "\(txtPassword.text ?? "0")"
        let urlString = "https://www.appae.net/grabacab/public/api/provider/oauth/token"
        guard let requestUrl = URL(string:urlString) else { return }
        let devid = UIDevice.current.identifierForVendor!.uuidString
        let parameters = "email=\(self.emailStr)&password=\(self.pwdStr)&device_token=1232324234234&device_id=\(devid)&device_type=ios"
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-unlencoded;charset=utf-8", forHTTPHeaderField: "Content-Length")
        request.httpBody = parameters.data(using: String.Encoding.utf8)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response {
                guard let data = data else { return }
                var json: [String: Any]?
                do {
                    json = try JSONSerialization.jsonObject(with: data) as? [String:Any]
                }catch{
                    print(error)
                }
                //print(json?["id"]! as Any)
                //print(json?["mobile"]! as Any)
                //print(json?["latitude"]! as Any)
                //print(json!)
                print("=====================================================")
                print(parameters)
                self.ttoken = json?["access_token"]! as! String
                print(self.ttoken)
            }
            }.resume()
        
        
        
        /*===============================================
        // to work with sign in button - my test block
 
        //"https://www.appae.net/grabacab/public/api/provider/trip?latitude=51.876480&longitude=-0.383426"
        //"https://www.appae.net/grabacab/public/api/provider/profile/available?service_status=active"
        //api/provider/target
        
        let urlStr = "https://www.appae.net/grabacab/public/api/provider/target"
        guard let reqUrl = URL(string: urlStr) else { return }
        
        var request1 = URLRequest(url: reqUrl)
        request1.httpMethod = "GET"
        //request1.setValue("application/x-www-form-unlencoded;charset=utf-8", forHTTPHeaderField: "Content-Length")
        request1.setValue("Bearer \(self.ttoken)", forHTTPHeaderField: "Authorization")
        request1.setValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
        
        
        
        //request1.httpBody = parameter1.data(using: String.Encoding.utf8)
        //let requestTrip = URLRequest(url: reqUrl as URL)
        //requestProfile.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request1) { (data, response, error) in
            //if let data1 = data {
                guard let data1 = data else { return }
                let dataString = String(data: data1, encoding: .utf8)
                print("=====================================================")
                print(dataString as Any)
                /*
                guard let data1 = data else { return }
                //var json1: [String: Any]?
                do {
                    guard let json1 = try JSONSerialization.jsonObject(with: data1, options: .mutableContainers) as? [String:Any] else { return }
                    print(json1 as Any)
                    self.ttoken = json1?["access_token"]! as! String
                }catch{
                    print(error)
                }
                */
                //print(response as Any)
                print("=====================================================")
                print(data1)
            //}
        }.resume()
        // my test block is end here
        */
 
    }
    
    

}
