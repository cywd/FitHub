//
//  NetworkManager.swift
//  FitHub
//
//  Created by Cyrill on 2017/11/22.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



protocol NetworkManagerProtocol {
    static func loadUserDataWith(_ page: Int, _ currentIndex: Int, completionHandler: @escaping (_ items: [UserModel], _ total_count: Int) -> ())
}

class NetworkManager: NetworkManagerProtocol {

    static func loadUserDataWith(_ page: Int, _ currentIndex: Int, completionHandler: @escaping (_ items: [UserModel], _ total_count: Int) -> ()) {
        let city = "beijing"
        let language = "all language"
        
        var q = "location:\(city)+language:\(language)"
        q = "location:\(city)"
        
        let baseUrl = "https://api.github.com"
        let string = "/search/users?q=\(q)&sort=\("followers")&page=\(page)"
        
        let url = baseUrl + string
        
        Alamofire.request(url, method: .get).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                
                let json = JSON(value)
                
                let total_count = json["total_count"].int
                
                if let items = json["items"].arrayObject {
                    
                    var models = [UserModel]()
                    for dict in items {
                        models.append(UserModel(dict: dict as! [String : AnyObject]))
                    }
                    
                    completionHandler(models, total_count!)
                    
                }

            }   
        }
    }

}
