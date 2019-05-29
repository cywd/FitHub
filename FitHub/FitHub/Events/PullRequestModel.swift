//
//  PullRequestModel.swift
//  FitHub
//
//  Created by Cyrill on 2017/11/30.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit

@objcMembers
class PullRequestModel: NSObject {

    var id: Int = 0
    var url: String?
    var html_url: String?
    var diff_url: String?
    var patch_url: String?
    var issue_url: String?
    var number: Int = 0
    var state: String?
    var isLocked: Bool = false
    var title: String?
    var body: String?
    var created_at: String?
    var updated_at: String?
    var closed_at: Any?
    var merged_at: Any?
    var merge_commit_sha: Any?
    var assignee: Any?
    var milestone: Any?
    var commits_url: String?
    var review_comments_url: String?
    var review_comment_url: String?
    var comments_url: String?
    var statuses_url: String?
    var head: [String: Any]?
    var base: [String: Any]?
    var _links: [String: Any]?
    var merged: Bool = false
    
    var mergeable: Any?
    var mergeable_state: String?
    var merged_by: Any?
    
    var comments: Int = 0
    var review_comments: Int = 0
    var commits: Int = 0
    var additions: Int = 0
    var deletions: Int = 0
    var changed_files: Int = 0
    var user: UserModel?
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if value == nil { return }
        super.setValue(value, forKey: key)
        if key == "user" {
            self.user = UserModel(dict: value as! [String : AnyObject])
        }
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
        
    }
    
}
