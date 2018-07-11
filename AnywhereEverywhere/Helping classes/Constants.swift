//
//  Constants.swift
//  AnywhereEverywhere
//
//  Created by Waheguru on 04/07/18.
//  Copyright © 2018 App AE. All rights reserved.
//

import Foundation
import UIKit

class Constants: NSObject
{
    static let BASE_URL                        = "https://www.appae.net/grabacab/public/"
    
    static let LOGIN                           = "api/provider/oauth/token"
    static let REGISTER                        = "api/provider/register"
}

class userID
{
    struct user
    {
        static var ID : String! = UserDefaults.standard.string(forKey: "userID") ?? ""
        static var email : String = UserDefaults.standard.string(forKey: "email") ?? ""
        static var password : String = UserDefaults.standard.string(forKey: "password") ?? ""
        static var deviceToken : String! = UserDefaults.standard.string(forKey: "deviceToken") ?? ""
        static var deviceUDID : String! = UIDevice.current.identifierForVendor!.uuidString
    }
}

let APPDELEGATE                            = UIApplication.shared.delegate as! AppDelegate
let APPWINDOW                              = APPDELEGATE.window
