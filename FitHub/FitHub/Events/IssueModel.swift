//
//  IssueModel.swift
//  FitHub
//
//  Created by Cyrill on 2017/12/4.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit

@objcMembers
class IssueModel: NSObject {
    
    var url: String?
    var repository_url: String?
    var labels_url: String?
    var comments_url: String?
    var events_url: String?
    var html_url: String?
    var id: Int = 0
    var number: Int = 0
    var title: String?
    var user: UserModel?
    
    var labels: [Any]?
    var state: String?
    var isLocked: Bool = false
    var assignee: Any?
    var assignees: [Any]?
    
    var milestone: Any?
    var comments: Int = 0
    var created_at: String?
    var updated_at: String?
    var closed_at: Any?
    var author_association: String?
    var body: String?

    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if value == nil { return }
        super.setValue(value, forKey: key)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}

