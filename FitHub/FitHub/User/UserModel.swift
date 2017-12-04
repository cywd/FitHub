//
//  UserModel.swift
//  FitHub
//
//  Created by Cyrill on 2017/11/22.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit

@objcMembers
class UserModel: NSObject {
    
    var login: String?
    var id: Int = 0
    var avatar_url: String?
    var gravatar_id: String? 
    var url: String?
    var html_url: String?
    var followers_url: String?
    var following_url: String?
    var gists_url: String?
    var starred_url: String?
    var subscriptions_url: String?
    var organizations_url: String?
    var repos_url: String?
    var events_url: String?
    var received_events_url: String?
    var type: String?
    var site_admin: Bool = false
    var score: Float = 0.0
    
    
    var name: String?
    var company: String?
    var blog: String?
    var location: String?
    var email: String?
    var isHireable: Bool = false
    var bio: String?
    var public_repos: Int = 0
    var public_gists: Int = 0
    var followers: Int = 0
    var following: Int = 0
    var created_at: String?
    var updated_at: String?
    var private_gists: Int = 0
    var owned_private_repos: Int = 0
    var disk_usage: Int = 0
    var collaborators: Int = 0
    var two_factor_authentication: Bool = false
    
    
    // actor
    var display_login: String?


    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if value == nil { return }
        super.setValue(value, forKey: key)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print(key)
    }
}
