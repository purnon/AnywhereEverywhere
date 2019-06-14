//
//  ViewController.swift
//  AnywhereEverywhere
//
//  Created by ALAM on 5/27/18.
//  Copyright © 2018 App AE. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet var ivogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        let identityAnimation = CGAffineTransform.identity
        let scaleOfIdentity = identityAnimation.scaledBy(x: 1.0, y: 1.0)
        ivogo.transform = scaleOfIdentity
        UIView.animate(withDuration: 1.5, animations: {
            let scaleOfIdentity = identityAnimation.scaledBy(x: 3.0, y: 3.0)
            self.ivogo.transform = scaleOfIdentity
        }, completion: {finished in
             self.performSegue(withIdentifier: "moveToSignIn", sender: nil)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }


}

