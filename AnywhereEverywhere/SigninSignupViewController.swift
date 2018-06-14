//
//  SigninSignupViewController.swift
//  AnywhereEverywhere
//
//  Created by ALAM on 5/27/18.
//  Copyright © 2018 App AE. All rights reserved.
//

import UIKit

class SigninSignupViewController: UIViewController {

    @IBOutlet weak var btnEmailID: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnEmailID.isHidden = true
        
        let urlString = "https://www.appae.net/grabacab/public/api/provider/oauth/token"
        guard let requestUrl = URL(string:urlString) else { return }
        let devid = UIDevice.current.identifierForVendor!.uuidString
        let parameters = "email=testdriver@gmail.com&password=Test@123&device_token=1232324234234&device_id=\(devid)&device_type=ios"
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-unlencoded;charset=utf-8", forHTTPHeaderField: "Cpntent-Type")
        request.httpBody = parameters.data(using: String.Encoding.utf8)
        
        //let jsonUrlString = "https://www.appae.net/grabacab/public/api/provider/oauth/token?email=testdriver@gmail.com&password=Test@123&device_token=1232324234234&device_id=\(devid)&device_type=ios"
        //email":_emailStr,@"password":_passwordText.text, @"device_token":@"1232324234234",@"device_id":appDelegate.device_UDID , @"device_type":@"ios
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil, let usableData = data {
                var json: [String: Any]?
                do {
                    json = try JSONSerialization.jsonObject(with: usableData) as? [String:Any]
                    print(json?["email"]! as Any)
                    print(json?["id"]! as Any)
                    print(data)
                }catch{
                    print(error)
                }
            }
        }.resume()
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
