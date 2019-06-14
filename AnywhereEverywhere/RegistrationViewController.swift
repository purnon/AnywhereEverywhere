//
//  RegistrationViewController.swift
//  AnywhereEverywhere
//
//  Created by ALAM on 5/28/18.
//  Copyright © 2018 App AE. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class RegistrationViewController: UIViewController, UITextFieldDelegate, NVActivityIndicatorViewable
{
    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var tfFullName: UITextField!
    @IBOutlet var tfPass: UITextField!
    @IBOutlet var tfConfirmPass: UITextField!
    @IBOutlet var tfPhoneNo: UITextField!
    
  
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: MOVE BACK
    @IBAction func moveBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: UITEXTFIELD DELEGATES
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
  
    
    // MARK: SIGN UP
    @IBAction func SignUp(_ sender: Any)
    {
        self.view.endEditing(true)
        
        let objComonEmail = AEUtilities()
        if tfEmail.text!.lengthOfBytes(using: String.Encoding.utf8) == 0
        {
            showAlert.myController(message: "Please enter Email", view: self, title: "Anywhere Everywhere")
        }
            
        else if tfPass.text!.lengthOfBytes(using: String.Encoding.utf8) == 0
        {
            showAlert.myController(message: "Please enter Password", view: self, title: "Anywhere Everywhere")
        }
        else if tfConfirmPass.text!.lengthOfBytes(using: String.Encoding.utf8) == 0
        {
            showAlert.myController(message: "Please enter Confirm Password", view: self, title: "Anywhere Everywhere")
        }
        else if tfPhoneNo.text!.lengthOfBytes(using: String.Encoding.utf8) == 0
        {
            showAlert.myController(message: "Please enter Phone Number", view: self, title: "Anywhere Everywhere")
        }
        else if !objComonEmail.isValidEmail(testStr: tfEmail.text!)
        {
            showAlert.myController(message: "Please Enter Valid Email Id", view: self, title: "Anywhere Everywhere")
        }
        else if tfPass.text!.lengthOfBytes(using: String.Encoding.utf8) < 8
        {
            showAlert.myController(message: "Please enter atleast 8 digits Password", view: self, title: "Anywhere Everywhere")
        }
        else if tfPass.text != tfConfirmPass.text
        {
            showAlert.myController(message: "Password doesn't Match!", view: self, title: "Anywhere Everywhere")
        }
        else
        {
            callWebserviceToRegister()
            
        }
    }
    
    // MARK: - WEB SERVICES
    func callWebserviceToRegister()
    {
        DispatchQueue.main.async
            {
                self.startAnimating(CGSize(width: 100, height:100), message: "", type: NVActivityIndicatorType.ballRotateChase)
        }
        
        let  strURL = "\(Constants.BASE_URL)\(Constants.REGISTER)?email=\(tfEmail.text!)&password=\(tfPass.text!)&password_confirmation=\(tfConfirmPass.text!)&device_type=ios&device_token=\(userID.user.deviceToken!)&login_by=manual&mobile=\(tfPhoneNo.text!)&first_name=\(tfFullName.text!)&last_name=\(tfFullName.text!)&device_id=\(userID.user.deviceUDID!)"
        print(strURL)
        
        let newURL : String = strURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let webServiceHelper = CallWebService()
        
        try! webServiceHelper.getDataforUrlUsingPostMethod(strURL: newURL) { (json, error) -> Void in
            
            DispatchQueue.main.async()
                {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self.stopAnimating()
                    print(json ?? "")
                    
                    if json == nil
                    {
                        showAlert.myController(message: "Email Already Exist", view: self, title: "Anywhere Everywhere")
                    }
                    else
                    {
                        self.tfEmail.text = ""
                         self.tfFullName.text = ""
                         self.tfConfirmPass.text = ""
                         self.tfPhoneNo.text = ""
                         self.tfPass.text = ""
                        userID.user.ID = String(json?["id"]! as! Int)
                        UserDefaults.standard.set(String(json?["id"]! as! Int), forKey: "userID")
                        UserDefaults.standard.synchronize()
                        
                        showAlert.myController(message: "User Registered Successfully", view: self, title: "Anywhere Everywhere")
                        self.navigationController?.popViewController(animated: true)
                    }
            }
        }
    }
    
}

