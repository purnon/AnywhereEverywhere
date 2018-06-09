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
        
        let jsonUrlString = "https://www.appae.net/grabacab/public/api/provider/oauth/token"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            let dataString = String(data: data, encoding: .utf8)
            print(dataString)
        
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
