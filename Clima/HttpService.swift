//
//  HttpService.swift
//  Clima
//
//  Created by Breno Rezende on 16/08/19.
//  Copyright © 2019 brezende. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct HttpService {
    
    func require(url: String, method: HTTPMethod, params: [String : String], completion: @escaping (_ : JSON?) -> Void) {
        
        Alamofire.request(url, method: method, parameters: params).responseJSON {
            response in
            
            if response.result.isSuccess {
                completion(JSON(response.result.value ?? String()))
            } else {
                print("Error: \(response.result.error)")
                completion(nil)
            }
        }
    }
}
