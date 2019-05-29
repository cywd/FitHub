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
    
    static func loadCommonUsers(withUrl urlStr: String, page: Int, success: @escaping (_ items: [UserModel]) -> (), failure: @escaping (Error) -> ())
    static func loadCommonRepos(withUrl urlStr: String, page: Int, success: @escaping (_ items: [RepositoryModel]) -> (), failure: @escaping (Error) -> ())
    static func loadOrgs(withUrl urlStr: String, page: Int, success: @escaping (_ items: [OrgModel]) -> (), failure: @escaping (Error) -> ())
    
    static func searchUser(name: String, success: @escaping (_ items: [UserModel]) -> (), failure: @escaping (Error) -> ())
    static func searchRepos(name: String, success: @escaping (_ items: [RepositoryModel]) -> (), failure: @escaping (Error) -> ())
    
    static func getTrendingRepository(success: @escaping (_ items: [RepositoryModel]) -> (), failure: @escaping (Error) -> ())
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - page: <#page description#>
    ///   - location: <#location description#>
    ///   - language: <#language description#>
    ///   - success: <#success description#>
    ///   - failure: <#failure description#>
    /// - Returns: <#return value description#>
    static func loadUserDataWith(page: Int, location: String, language: String, success: @escaping (_ items: [UserModel], _ total_count: Int) -> (), failure: @escaping (Error) -> ())
    
    static func loadOrgDataWith(orgName: String, success: @escaping (OrgModel) -> (), failure: @escaping (Error) -> ())
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - userName: <#userName description#>
    ///   - success: <#success description#>
    ///   - failure: <#failure description#>
    /// - Returns: <#return value description#>
    static func loadUserDetailDataWith(userName: String, success: @escaping (UserModel) -> (), failure: @escaping (Error) -> ())
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - page: <#page description#>
    ///   - userName: <#userName description#>
    ///   - success: <#success description#>
    ///   - failure: <#failure description#>
    /// - Returns: <#return value description#>
    static func loadUserRepositoriesDataWith(page: Int, userName: String, success: @escaping (_ items: [RepositoryModel]) -> (), failure: @escaping (Error) -> ())
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - page: <#page description#>
    ///   - userName: <#userName description#>
    ///   - success: <#success description#>
    ///   - failure: <#failure description#>
    /// - Returns: <#return value description#>
    static func loadUserFollowersDataWith(page: Int, userName: String, success: @escaping ([UserModel]) -> (), failure: @escaping (Error) -> ())
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - page: <#page description#>
    ///   - userName: <#userName description#>
    ///   - success: <#success description#>
    ///   - failure: <#failure description#>
    /// - Returns: <#return value description#>
    static func loadUserFollowingDataWith(page: Int, userName: String, success: @escaping ([UserModel]) -> (), failure: @escaping (Error) -> ())
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - userName: <#userName description#>
    ///   - repositoryName: <#repositoryName description#>
    ///   - success: <#success description#>
    ///   - failure: <#failure description#>
    /// - Returns: <#return value description#>
    static func repositoryDetailWith(userName: String, repositoryName: String, success: @escaping (RepositoryModel) -> (), failure: @escaping (Error) -> ())
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - name: <#name description#>
    ///   - pwd: <#pwd description#>
    ///   - success: <#success description#>
    ///   - failure: <#failure description#>
    /// - Returns: <#return value description#>
    static func login(name: String, pwd: String, success: @escaping ()->(), failure: @escaping (Int, Error) -> ())
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - page: <#page description#>
    ///   - username: <#username description#>
    ///   - success: <#success description#>
    ///   - failure: <#failure description#>
    static func getRepositoriesEventsWith(page: Int, username: String, success: @escaping ([EventModel]) -> (), failure: @escaping (Error) -> ())

    static func loadLicenseData(withUrl urlStr: String, success: @escaping (_ model: LicenseModel) -> (), failure: @escaping (Error) -> ())
    
    static func loadContentsData(withUrl urlStr: String, success: @escaping (_ model: [ContentModel]) -> (), failure: @escaping (Error) -> ())
    static func loadContentData(withUrl urlStr: String, success: @escaping (_ model: ContentModel) -> (), failure: @escaping (Error) -> ())
    
    
    static func isStared(username: String, repoName: String, success: @escaping () -> (), failure: @escaping (Error) -> ())
    
    static func star(username: String, repoName: String, success: @escaping () -> (), failure: @escaping (Error) -> ())
    
    static func unStar(username: String, repoName: String, success: @escaping () -> (), failure: @escaping (Error) -> ())
    
    static func isFollowed(username: String, success: @escaping () -> (), failure: @escaping (Error) -> ())
    
    static func follow(username: String, success: @escaping () -> (), failure: @escaping (Error) -> ())
    
    static func unFollow(username: String, success: @escaping () -> (), failure: @escaping (Error) -> ())
}

class NetworkManager: NetworkManagerProtocol {
    
    static func searchUser(name: String, success: @escaping (_ items: [UserModel]) -> (), failure: @escaping (Error) -> ()) {
        
        let url = "https://api.github.com/search/users?q=\(name)"
        let header = self.getHeader()
        Alamofire.request(url, method: .get, headers:header).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
//                let total_count = json["total_count"].int
                
                if let items = json["items"].arrayObject {
                    
                    var models = [UserModel]()
                    for dict in items {
                        models.append(UserModel(dict: dict as! [String : AnyObject]))
                    }
                    
                    success(models)
                    
                }
                break
            case .failure(let error):
                
                failure(error)
                
                break
            }
        }
    }
    
    static func searchRepos(name: String, success: @escaping (_ items: [RepositoryModel]) -> (), failure: @escaping (Error) -> ()) {
        
        let url = "https://api.github.com/search/repositories?q=\(name)"
        let header = self.getHeader()
        Alamofire.request(url, method: .get, headers:header).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
//                let total_count = json["total_count"].int
                
                if let items = json["items"].arrayObject {
                    
                    var models = [RepositoryModel]()
                    for dict in items {
                        models.append(RepositoryModel(dict: dict as! [String : AnyObject]))
                    }
                    success(models)
                }
                break
            case .failure(let error):
                failure(error)
                break
            }
        }
    }
    
    static func getTrendingRepository(success: @escaping (_ items: [RepositoryModel]) -> (), failure: @escaping (Error) -> ()) {
        
        let url = "https://raw.githubusercontent.com/cywd/cywd.github.io/master/json/trending.json"
        let header = self.getHeader()
        Alamofire.request(url, method: .get, headers:header).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                if let items = json.arrayObject {
                    
                    var models = [RepositoryModel]()
                    for dict in items {
                        models.append(RepositoryModel(dict: dict as! [String : AnyObject]))
                    }
                    success(models)
                }
                break
            case .failure(let error):
                failure(error)
                break
            }
        }
        
    }
    
    static func loadCommonUsers(withUrl urlStr: String, page: Int, success: @escaping (_ items: [UserModel]) -> (), failure: @escaping (Error) -> ()) {
        
        let url = "\(urlStr)?page=\(page)"
        let header = self.getHeader()
        Alamofire.request(url, method: .get, headers:header).responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                if let items = json.arrayObject {
                    
                    var models = [UserModel]()
                    for dict in items {
                        models.append(UserModel(dict: dict as! [String : AnyObject]))
                    }
                    
                    success(models)
                }
                
                break
            case .failure(let error):
                failure(error)
                break
            }
        }
    }
    
    /*
     Parameters
     Name    Type    Description
     visibility    string    Can be one of all, public, or private. Default: all
     affiliation    string    Comma-separated list of values. Can include:
     * owner: Repositories that are owned by the authenticated user.
     * collaborator: Repositories that the user has been added to as a collaborator.
     * organization_member: Repositories that the user has access to through being a member of an organization. This includes every repository on every team that the user is on.
     
     Default: owner,collaborator,organization_member
     type    string    Can be one of all, owner, public, private, member. Default: all
     
     Will cause a 422 error if used in the same request as visibility or affiliation.
     sort    string    Can be one of created, updated, pushed, full_name. Default: full_name
     direction    string    Can be one of asc or desc. Default: when using full_name: asc; otherwise desc
     
     */
    static func loadCommonRepos(withUrl urlStr: String, page: Int, success: @escaping (_ items: [RepositoryModel]) -> (), failure: @escaping (Error) -> ()) {
        
        let url = "\(urlStr)?page=\(page)&sort=created"
        let header = self.getHeader()
        Alamofire.request(url, method: .get, headers:header).responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                if let items = json.arrayObject {
                    
                    var models = [RepositoryModel]()
                    for dict in items {
                        models.append(RepositoryModel(dict: dict as! [String : AnyObject]))
                    }
                    
                    success(models)
                }
                
                break
            case .failure(let error):
                failure(error)
                break
            }
        }
    }
    
    static func loadOrgs(withUrl urlStr: String, page: Int, success: @escaping (_ items: [OrgModel]) -> (), failure: @escaping (Error) -> ()) {
        let url = "\(urlStr)?page=\(page)"
        let header = self.getHeader()
        Alamofire.request(url, method: .get, headers:header).responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                if let items = json.arrayObject {
                    
                    var models = [OrgModel]()
                    for dict in items {
                        models.append(OrgModel(dict: dict as! [String : AnyObject]))
                    }
                    
                    success(models)
                }
                
                break
            case .failure(let error):
                failure(error)
                break
            }
        }
    }
    
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

    static func loadUserDetailDataWith(userName: String, success: @escaping (UserModel) -> (), failure: @escaping (Error) -> ()) {
        let baseUrl = "https://api.github.com"
        var string = "/users/\(userName)"
        
        if userName == UserSessionManager.myself?.login {
            string = "/user"
        }
        
        
        let url = baseUrl + string
        let header = self.getHeader()
        Alamofire.request(url, method: .get, headers:header).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                if let dataDict = json.dictionaryObject {
                    let model = UserModel(dict: dataDict as [String : AnyObject])
                    success(model)
                }
                
                break
            case .failure(let error):
                failure(error)
                break
            }
           
        }
    }
    
    static func loadOrgDataWith(orgName: String, success: @escaping (OrgModel) -> (), failure: @escaping (Error) -> ()) {
        let baseUrl = "https://api.github.com"
        let string = "/orgs/\(orgName)"
        
        let url = baseUrl + string
        let header = self.getHeader()
        Alamofire.request(url, method: .get, headers:header).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                if let dataDict = json.dictionaryObject {
                    let model = OrgModel(dict: dataDict as [String : AnyObject])
                    success(model)
                }
                
                break
            case .failure(let error):
                failure(error)
                break
            }
            
        }
    }
    
    //https://developer.github.com/v3/repos/#list-user-repositories
    //List user repositories
    //GET /users/:username/repos
    static func loadUserRepositoriesDataWith(page: Int, userName: String, success: @escaping ([RepositoryModel]) -> (), failure: @escaping (Error) -> ()) {

        let baseUrl = "https://api.github.com"
        let string = "/users/\(userName)/repos?sort=updated&page=\(page)"
        
        let url = baseUrl + string
        let header = self.getHeader()
        Alamofire.request(url, method: .get, headers:header).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                
                if let list = json.arrayObject {
                    
                    var models = [RepositoryModel]()
                    for dict in list {
                        let model = RepositoryModel(dict: dict as! [String : AnyObject])
                        models.append(model)
                    }
                    
                    success(models)
                }
                
                break
            case .failure(let error):
                failure(error)
                break
            }
           
        }
    }
    
    //List followers of a user
    //https://developer.github.com/v3/users/followers/#list-followers-of-a-user
    //GET /users/:username/followers
    static func loadUserFollowersDataWith(page: Int, userName: String, success: @escaping ([UserModel]) -> (), failure: @escaping (Error) -> ()) {
        let baseUrl = "https://api.github.com"
        let string = "/users/\(userName)/followers?page=\(page)"
        
        let url = baseUrl + string
        let header = self.getHeader()
        Alamofire.request(url, method: .get, headers:header).responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                if let items = json.arrayObject {
                    
                    var models = [UserModel]()
                    for dict in items {
                        models.append(UserModel(dict: dict as! [String : AnyObject]))
                    }
                    
                    success(models)
                }
                
                break
            case .failure(let error):
                failure(error)
                break
            }
        }
    }
    
    
    static func loadUserFollowingDataWith(page: Int, userName: String, success: @escaping ([UserModel]) -> (), failure: @escaping (Error) -> ()) {
        let baseUrl = "https://api.github.com"
        let string = "/users/\(userName)/following?page=\(page)"
        
        let url = baseUrl + string
        let header = self.getHeader()
        Alamofire.request(url, method: .get, headers:header).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                if let items = json.arrayObject {
                    
                    var models = [UserModel]()
                    for dict in items {
                        models.append(UserModel(dict: dict as! [String : AnyObject]))
                    }
                    
                    success(models)
                }
                
                break
            case .failure(let error):
                failure(error)
                break
            }
            
        }
    }
    
    static func repositoryDetailWith(userName: String, repositoryName: String, success: @escaping (RepositoryModel) -> (), failure: @escaping (Error) -> ()) {
        
        let baseUrl = "https://api.github.com"
        let string = "/repos/\(userName)/\(repositoryName)"
        
        let url = baseUrl + string
        let header = self.getHeader()
        Alamofire.request(url, method: .get, headers: header).responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                
                if let dataDict = json.dictionaryObject {
                    let model = RepositoryModel(dict: dataDict as [String : AnyObject])
                    success(model)
                }
                
                break
            case .failure(let error):
                failure(error)
                break
            }
            
        }
    }
    
    static func login(name: String, pwd: String, success: @escaping () -> (), failure: @escaping (Int, Error) -> ()) {
        
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
            "client_secret" : "ac0fbe152c8940c2bb1a71a80a849d1f5eba9aed",
            "fingerprint" : name
        ] as [String : Any]
   
        let header = self.addAuthorizationHead(username: name, pwd: pwd)
        UserDefaults.standard.set(header, forKey: "header")
        
        Alamofire.request(url, method: .post, parameters: dic, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in

            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let token = json["token"].string
                
                if token == nil {
                    if let status = response.response?.statusCode {
                        
                        guard status == 422 else {
                            failure(status, NSError(domain: "error", code: 999, userInfo: nil))
                            return
                        }
                    } else {
                        failure(0, NSError(domain: "error", code: 999, userInfo: nil))
                        return
                    }
                    
                }
                
                UserDefaults.standard.set(true, forKey: "isLogin")
                
                UserSessionManager.save(token: token)
                
                self.loadUserDetailDataWith(userName: name, success: { (userModel) in
                    UserSessionManager.save(user: userModel)
                    success()
                }, failure: { (err) in
                    failure(0, err)
                })
                
                break
            case .failure(let error):
                failure(0, error)
                break
            }

        }
    }
    
    static func getRepositoriesEventsWith(page: Int, username: String, success: @escaping ([EventModel]) -> (), failure: @escaping (Error) -> ()) {
        
        let baseUrl = "https://api.github.com"
        let string = "/users/\(username)/received_events?page=\(page)"
        let url = baseUrl + string
        
        let header = self.getHeader()
        Alamofire.request(url, method: HTTPMethod.get, parameters: nil, headers: header).responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                
                if let items = json.arrayObject {
                    
                    var models = [EventModel]()
                    for dict in items {
                        models.append(EventModel(dict: dict as! [String : AnyObject]).eventWrap())
                    }
                    success(models)
                }
                
                break
            case .failure(let error):
                
                failure(error)
                break
            }
        }
    }
    
    static func loadLicenseData(withUrl urlStr: String, success: @escaping (_ model: LicenseModel) -> (), failure: @escaping (Error) -> ()) {
        let url = urlStr
        let header = self.getHeader()
        Alamofire.request(url, method: .get, headers:header).responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                if let dataDict = json.dictionaryObject {
                    let model = LicenseModel(dict: dataDict as [String : AnyObject])
                    success(model)
                }
                
                break
            case .failure(let error):
                failure(error)
                break
            }
        }
    }
    
    static func loadContentsData(withUrl urlStr: String, success: @escaping (_ model: [ContentModel]) -> (), failure: @escaping (Error) -> ()) {
        
        let url = urlStr
        let header = self.getHeader()
        
        Alamofire.request(url, method: HTTPMethod.get, parameters: nil, headers: header).responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                
                if let items = json.arrayObject {
                    
                    var models = [ContentModel]()
                    for dict in items {
                        models.append(ContentModel(dict: dict as! [String : AnyObject]))
                    }
                    success(models)
                }
                
                break
            case .failure(let error):
                
                failure(error)
                break
            }
        }
    }
    
    static func loadContentData(withUrl urlStr: String, success: @escaping (_ model: ContentModel) -> (), failure: @escaping (Error) -> ()) {
        let url = urlStr
        let header = self.getHeader()
        Alamofire.request(url, method: .get, headers:header).responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                if let dataDict = json.dictionaryObject {
                    let model = ContentModel(dict: dataDict as [String : AnyObject])
                    success(model)
                }
                
                break
            case .failure(let error):
                failure(error)
                break
            }
        }
    }
    
    static func isStared(username: String, repoName: String, success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        self.starable(username: username, repoName: repoName, type: .get, success: success, failure: failure)
    }
    
    static func star(username: String, repoName: String, success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        self.starable(username: username, repoName: repoName, type: .put, success: success, failure: failure)
    }
    
    static func unStar(username: String, repoName: String, success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        self.starable(username: username, repoName: repoName, type: .delete, success: success, failure: failure)
    }
    
    static func starable(username: String, repoName: String, type: HTTPMethod, success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        let baseUrl = "https://api.github.com"
        let string = "/user/starred/\(username)/\(repoName)"
        let url = baseUrl + string
        
        let header = self.getHeader()
        Alamofire.request(url, method: type, parameters: nil, headers: header).responseJSON { (response) in
            
            switch response.result {
            case .success(_):
                
                if response.response?.statusCode == 204 {
                    success()
                } else {
                    let error = NSError(domain: "error", code: 999, userInfo: nil)
                    failure(error)
                }
                
                break
            case .failure(let error):
                
                failure(error)
                break
            }
        }
    }
    
    
    /// Check if you are following a user
    static func isFollowed(username: String, success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        self.followable(username: username, type: .get, success: success, failure: failure)
    }
    
    static func follow(username: String, success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        self.followable(username: username, type: .put, success: success, failure: failure)
    }
    
    static func unFollow(username: String, success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        self.followable(username: username, type: .delete, success: success, failure: failure)
    }
    
    static func followable(username: String, type: HTTPMethod, success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        let baseUrl = "https://api.github.com"
        let string = "/user/following/\(username)"
        let url = baseUrl + string
        
        let header = self.getHeader()
        Alamofire.request(url, method: type, parameters: nil, headers: header).responseJSON { (response) in
            
            switch response.result {
            case .success(_):
                
                if response.response?.statusCode == 204 {
                    success()
                } else {
                    let error = NSError(domain: "error", code: 999, userInfo: nil)
                    failure(error)
                }
                
                break
            case .failure(let error):
                
                failure(error)
                break
            }
        }
    }
    
    // MARK: - tool
    
    class func isLogin() -> Bool {
        if let isLogin = UserDefaults.standard.value(forKey: "isLogin") {
            return isLogin as! Bool
        } else {
            return false
        }
    }
    
    class func logout() {
        self.removeLoginInfo()
    }
    
    // MARK: - private
    fileprivate class func getHeader() -> [String: String]! {
        var header = [String: String]()
        header["headers"] = "application/vnd.github.v3+json"
        header["User-Agent"] = "FirHub"
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
    
    private class func removeLoginInfo() {
        UserDefaults.standard.removeObject(forKey: "header")
        UserDefaults.standard.removeObject(forKey: "isLogin")
//        UserDefaults.standard.removeObject(forKey: "token")
        UserSessionManager.removeToken()
        UserSessionManager.removeUser()
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
