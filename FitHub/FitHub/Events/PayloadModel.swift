//
//  PayloadModel.swift
//  FitHub
//
//  Created by Cyrill on 2017/11/30.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit

class PayloadModel: NSObject {
    
    var action: String?
    
    // create
    var ref: String?
    var ref_type: String?
    var master_branch: String?
    var payloadDescription: String?
    var pusher_type: String?
    
    var forkee: RepositoryModel?
    
    // member membership
    var member: UserModel?
    var scope: String?
    var organization: OrgModel?
    var team: TeamModel?
    
    // opened
    var number: Int = 0
    var pull_request: PullRequestModel?
    
    // issue
    var comment: CommentModel?
    var issue: [String: Any]?
    
    // Deployment
    var deployment: DeploymentModel?
    
    var deployment_status: DeploymentStatusModel?
    
    
    // push
    var before: String?
    var after: String?
    var isCreate: Bool = false
    var isDeleted: Bool = false
    var isForced: Bool = false
    var base_ref: String?
    var compare: String?
    
    var commits: [String: Any]?
    var head_commit: [String: Any]?
    
    var pusher: UserModel?
    
    
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if value == nil { return }
        super.setValue(value, forKey: key)
        if key == "organization" {
            self.organization = OrgModel(dict: value as! [String : AnyObject])
        } else if key == "forkee" {
            self.forkee = RepositoryModel(dict: value as! [String: AnyObject])
        } else if key == "member" {
            self.member = UserModel(dict: value as! [String: AnyObject])
        } else if key == "team" {
            self.team = TeamModel(dict: value as! [String: AnyObject])
        } else if key == "pull_request" {
            self.pull_request = PullRequestModel(dict: value as! [String: AnyObject])
        } else if key == "comment" {
            self.comment = CommentModel(dict: value as! [String: AnyObject])
        } else if key == "deployment" {
            self.deployment = DeploymentModel(dict: value as! [String: AnyObject])
        } else if key == "deployment_status" {
            self.deployment_status = DeploymentStatusModel(dict: value as! [String: AnyObject])
        } else if key == "pusher" {
            self.pusher = UserModel(dict: value as! [String: AnyObject])
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print(key)
        
    }
    
}
