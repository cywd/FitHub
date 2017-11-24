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
    
    static func loadUserDataWith(page: Int, location: String, language: String, completionHandler: @escaping (_ items: [UserModel], _ total_count: Int) -> ())
    static func loadUserDetailDataWith(userName: String, completionHandler: @escaping (UserModel) -> ())
    static func loadUserRepositoriesDataWith(page: Int, userName: String, completionHandler: @escaping (_ items: [RepositoryModel]) -> ())
    static func loadUserFollowersDataWith(page: Int, userName: String, completionHandler: @escaping ([UserModel]) -> ())
    static func loadUserFollowingDataWith(page: Int, userName: String, completionHandler: @escaping ([UserModel]) -> ())
    static func repositoryDetailWith(userName: String, repositoryName: String, completionHandler: @escaping (RepositoryModel) -> ())
}

class NetworkManager: NetworkManagerProtocol {
    
    static func loadUserDataWith(page: Int, location: String, language: String, completionHandler: @escaping (_ items: [UserModel], _ total_count: Int) -> ()) {
        
        var locationStr = ""
        if location != "" {
            locationStr = "location:\(location)"
        }
        var plus = ""
        if locationStr != "" {
            plus = "+"
        }
        
        var languageStr = ""
        if language != "" {
            languageStr = "language:\(language)"
        }
        
        let q = locationStr + plus + languageStr
        
        let baseUrl = "https://api.github.com"
        let string = "/search/users?q=\(q)&sort=\("followers")&page=\(page)"
        
        let url = baseUrl + string
        
        Alamofire.request(url, method: .get, headers:["headers":"application/vnd.github.v3+json"]).responseJSON { (response) in
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
        
        Alamofire.request(url, method: .get, headers:["headers":"application/vnd.github.v3+json"]).responseJSON { (response) in
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
    
    //https://developer.github.com/v3/repos/#list-user-repositories
    //List user repositories
    //GET /users/:username/repos
    static func loadUserRepositoriesDataWith(page: Int, userName: String, completionHandler: @escaping ([RepositoryModel]) -> ()) {

        let baseUrl = "https://api.github.com"
        let string = "/users/\(userName)/repos?sort=updated&page=\(page)"
        
        let url = baseUrl + string
        
        Alamofire.request(url, method: .get, headers:["headers":"application/vnd.github.v3+json"]).responseJSON { (response) in
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
    
    //List followers of a user
    //https://developer.github.com/v3/users/followers/#list-followers-of-a-user
    //GET /users/:username/followers
    static func loadUserFollowersDataWith(page: Int, userName: String, completionHandler: @escaping ([UserModel]) -> ()) {
        let baseUrl = "https://api.github.com"
        let string = "/users/\(userName)/followers?page=\(page)"
        
        let url = baseUrl + string
        
        Alamofire.request(url, method: .get, headers:["headers":"application/vnd.github.v3+json"]).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            
            if let value = response.result.value {
                
                let json = JSON(value)
                
                if let items = json.arrayObject {
                    
                    var models = [UserModel]()
                    for dict in items {
                        models.append(UserModel(dict: dict as! [String : AnyObject]))
                    }
                    
                    completionHandler(models)
                }
            }
        }
    }
    
    
    static func loadUserFollowingDataWith(page: Int, userName: String, completionHandler: @escaping ([UserModel]) -> ()) {
        let baseUrl = "https://api.github.com"
        let string = "/users/\(userName)/following?page=\(page)"
        
        let url = baseUrl + string
        
        Alamofire.request(url, method: .get, headers:["headers":"application/vnd.github.v3+json"]).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            
            if let value = response.result.value {
                
                let json = JSON(value)
                
                if let items = json.arrayObject {
                    
                    var models = [UserModel]()
                    for dict in items {
                        models.append(UserModel(dict: dict as! [String : AnyObject]))
                    }
                    
                    completionHandler(models)
                }
            }
        }
    }
    
    static func repositoryDetailWith(userName: String, repositoryName: String, completionHandler: @escaping (RepositoryModel) -> ()) {
        let baseUrl = "https://api.github.com"
        let string = "/repos/\(userName)/\(repositoryName)"
        
        let url = baseUrl + string
        
        Alamofire.request(url, method: .get, headers:["headers":"application/vnd.github.v3+json"]).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            
            if let value = response.result.value {
                
                let json = JSON(value)
                
                if let dataDict = json.dictionaryObject {
                    let model = RepositoryModel(dict: dataDict as [String : AnyObject])
                    completionHandler(model)
                }
            }
        }
    }
    
    
    
}
