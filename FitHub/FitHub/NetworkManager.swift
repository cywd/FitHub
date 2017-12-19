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
    
    static func loadUserDataWith(page: Int, location: String, language: String, success: @escaping (_ items: [UserModel], _ total_count: Int) -> (), failure: @escaping (Error) -> ())
    static func loadUserDetailDataWith(userName: String, completionHandler: @escaping (UserModel) -> ())
    static func loadUserRepositoriesDataWith(page: Int, userName: String, completionHandler: @escaping (_ items: [RepositoryModel]) -> ())
    static func loadUserFollowersDataWith(page: Int, userName: String, completionHandler: @escaping ([UserModel]) -> ())
    static func loadUserFollowingDataWith(page: Int, userName: String, completionHandler: @escaping ([UserModel]) -> ())
    static func repositoryDetailWith(userName: String, repositoryName: String, completionHandler: @escaping (RepositoryModel) -> ())
    
    static func login(name: String, pwd: String, completionHandler: @escaping ()->())
    
    static func getRepositoriesEventsWith(page: Int, username: String, completionHandler: @escaping ([EventModel]) -> ())
}

class NetworkManager: NetworkManagerProtocol {
    
    
    static func loadUserDataWith(page: Int, location: String, language: String, success: @escaping (_ items: [UserModel], _ total_count: Int) -> (), failure: @escaping (Error) -> ()) {
        
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
        
        
        let header = self.getHeader()
        
        Alamofire.request(url, method: .get, headers:header).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let total_count = json["total_count"].int
                
                if let items = json["items"].arrayObject {
                    
                    var models = [UserModel]()
                    for dict in items {
                        models.append(UserModel(dict: dict as! [String : AnyObject]))
                    }
                    
                    success(models, total_count!)
                    
                }
                break
            case .failure(let error):
                
                failure(error)
                
                break
            }
        }
    }

    static func loadUserDetailDataWith(userName: String, completionHandler: @escaping (UserModel) -> ()) {
        let baseUrl = "https://api.github.com"
        let string = "/users/\(userName)"
        
        let url = baseUrl + string
        let header = self.getHeader()
        Alamofire.request(url, method: .get, headers:header).responseJSON { (response) in
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
        let header = self.getHeader()
        Alamofire.request(url, method: .get, headers:header).responseJSON { (response) in
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
        let header = self.getHeader()
        Alamofire.request(url, method: .get, headers:header).responseJSON { (response) in
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
        let header = self.getHeader()
        Alamofire.request(url, method: .get, headers:header).responseJSON { (response) in
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
        let header = self.getHeader()
        Alamofire.request(url, method: .get, headers:header).responseJSON { (response) in
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
    
    static func login(name: String, pwd: String, completionHandler:@escaping ()->()) {
        let baseUrl = "https://api.github.com"
        let string = "/authorizations"
        let url = baseUrl + string
        let dic = [
            "note" : "FitHub APP Token",
            "scopes" : [
                "public_repo",
                "repo",
                "user",
                "gist"
            ],
            "client_id" : "8d53a809cf0b28bb1ff7",
            "client_secret" : "ac0fbe152c8940c2bb1a71a80a849d1f5eba9aed"
        ] as [String : Any]
   
        let header = self.addAuthorizationHead(username: name, pwd: pwd)
        UserDefaults.standard.set(header, forKey: "header")
        
        Alamofire.request(url, method: .post, parameters: dic, encoding: JSONEncoding.default, headers:
            header).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }

            if let value = response.result.value {
                let json = JSON(value)
                let token = json["token"].string
                
                UserDefaults.standard.set(true, forKey: "isLogin")
                UserDefaults.standard.set(token, forKey: "token")
                UserDefaults.standard.set(name, forKey: "username")
                completionHandler()
            }
        }
    }
    
    static func getRepositoriesEventsWith(page: Int, username: String, completionHandler: @escaping ([EventModel]) -> ()) {
        
        let baseUrl = "https://api.github.com"
        let string = "/users/\(username)/received_events?page=\(page)"
        let url = baseUrl + string
        
        let header = self.getHeader()
        Alamofire.request(url, method: HTTPMethod.get, parameters: nil, headers: header).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            
            if let value = response.result.value {
                let json = JSON(value)
                
                if let items = json.arrayObject {
                    
                    var models = [EventModel]()
                    for dict in items {
                        models.append(EventModel(dict: dict as! [String : AnyObject]).eventWrap())
                    }
                    completionHandler(models)
                }

            }
        }
    }
    
    
    // MARK: - private
    class func isLogin() -> Bool {
        if let isLogin = UserDefaults.standard.value(forKey: "isLogin") {
            return isLogin as! Bool
        } else {
            return false
        }
        
    }
    
    fileprivate class func getHeader() -> [String: String]! {
        var header = [String: String]()
        header["headers"] = "application/vnd.github.v3+json"
        if self.isLogin() {
            if let tt = UserDefaults.standard.value(forKey: "header") {
                let aa = tt as! [String : String]
                for (key, value) in aa {
                    header[key] = value
                }
            }
        }
        return header
    }
    
    fileprivate class func addAuthorizationHead(base64UsernameAndPwd: String) -> [String: String] {
        let jsonStr = "Basic " + base64UsernameAndPwd
        return ["Authorization": jsonStr]
    }
    
    fileprivate class func addAuthorizationHead(username: String, pwd: String) -> [String: String] {
        let nameAndPwd = username + ":" + pwd
        let data = nameAndPwd.data(using: String.Encoding.utf8)
        let jsonStr = "Basic " + String(data!.base64EncodedString())
        return ["Authorization": jsonStr]
    }
    
}
