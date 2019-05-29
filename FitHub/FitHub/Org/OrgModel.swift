//
//  OrgModel.swift
//  FitHub
//
//  Created by Cyrill on 2017/11/30.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit

@objcMembers
class OrgModel: NSObject {

    var id: Int = 0
    var login: String?
    var gravatar_id: String?
    var url: String?
    var avatar_url: String?
    var repos_url: String?
    var events_url: String?
    var hooks_url: String?
    var issues_url: String?
    var members_url: String?
    var public_members_url: String?
    var desc: String?
    var name: String?
    var company: String?
    var blog: String?
    var location: String?
    
    var billing_email: String?
    var email: String?
    var has_organization_projects: Bool = false
    var has_repository_projects: Bool = false
    var public_repos: Int = 0
    var public_gists: Int = 0
    var private_gists: Int = 0
    var followers: Int = 0
    var following: Int = 0
    var html_url: String?
    var created_at: String?
    var updated_at: String?
    var type: String?
    var default_repository_permission: String?
    var members_can_create_repositories: Bool = false
    var collaborators: Int = 0
    var total_private_repos: Int = 0
    var owned_private_repos: Int = 0
    var disk_usage: Int = 0
    

    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }

    override func setValue(_ value: Any?, forKey key: String) {
        if value == nil { return }
        super.setValue(value, forKey: key)
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
        
        if key == "description" {
            self.desc = value as? String
        }
    }

}
