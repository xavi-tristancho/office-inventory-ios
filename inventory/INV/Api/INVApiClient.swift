//
//  INVApiClient.swift
//  inventory
//
//  Created by Xavier Tristancho Bordoy on 24/2/16.
//  Copyright © 2016 xavitb3. All rights reserved.
//

import Alamofire

class INVApiClient: NSObject {

    let baseURLString = "http://52.48.158.208:3001/api/"
    
    let headers = [
        "Content-Type": "application/json"
    ]
    
    func request(method: Alamofire.Method,
        uri: String,
        parameters: NSDictionary?,
        encoding: Alamofire.ParameterEncoding,
        success: (response: AnyObject!) -> Void,
        failure: (error: NSError?) -> Void){
            
            Alamofire.request(method, baseURLString + uri, parameters: parameters as? [String : AnyObject], headers: headers, encoding: encoding).validate().responseJSON { response in
                
                switch response.result {
                case .Success:
                    if let JSON = response.result.value {
                        success(response: JSON)
                    }
                case .Failure(let error):
                    failure(error: error)
                }
            }
    }
}
