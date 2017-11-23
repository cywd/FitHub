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
    static func loadUserDetailDataWith(userName: String, completionHandler: @escaping (UserModel) -> ())
    static func loadUserRepositoriesDataWith(_ page: Int, _ userName: String, completionHandler: @escaping (_ items: [RepositoryModel]) -> ())
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

    static func loadUserDetailDataWith(userName: String, completionHandler: @escaping (UserModel) -> ()) {
        let baseUrl = "https://api.github.com"
        let string = "/users/\(userName)"
        
        let url = baseUrl + string
        
        Alamofire.request(url, method: .get).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                
                let json = JSON(value)
                
                if let dataDict = json.dictionaryObject {
                    let model = UserModel(dict: dataDict as [String : AnyObject])
                    completionHandler(model)
                }
            }
        }
    }
    
    static func loadUserRepositoriesDataWith(_ page: Int, _ userName: String, completionHandler: @escaping ([RepositoryModel]) -> ()) {

        let baseUrl = "https://api.github.com"
        let string = "/users/\(userName)/repos?sort=updated&page=\(page)"
        
        let url = baseUrl + string
        
        Alamofire.request(url, method: .get).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                
                let json = JSON(value)
                
                if let list = json.arrayObject {
                    
                    var models = [RepositoryModel]()
                    for dict in list {
                        let model = RepositoryModel(dict: dict as! [String : AnyObject])
                        models.append(model)
                    }
                    
                    completionHandler(models)
                }
                
            }
        }
    }
    
    
}
