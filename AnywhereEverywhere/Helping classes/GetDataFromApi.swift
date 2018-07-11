//
//  WebService.swift


//  Created by Pollysys on 18/10/16.
//  Copyright © 2016 Pollysys. All rights reserved.
//


import Foundation

public class CallWebService
{

    func getDataforUrlUsingPostMethod(strURL: String, completion: @escaping (_ responseObject: AnyObject?, _ error: NSError?) -> (Void)) throws -> URLSessionTask?
    {
        
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let request  = NSMutableURLRequest()
        request.url = NSURL(string: strURL)! as URL
        print(request)
        request.httpMethod = "POST"
        
        let task = session.dataTask(with: request as URLRequest)
        {
            (data, response, error) in
            
            print(request)
            if error != nil
            {
                completion(nil, error as NSError?)
                print(error!)
                return
            }
            else
            {
                let result = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                do {
                    print(result!)
                    let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions())
                    completion(json as AnyObject?, error as NSError?)
                    
                } catch
                {
                    let nserror = error as NSError
                    completion(nil, nserror)
                }
            }

        }
        
        task.resume()
        return task
    }
    
}








