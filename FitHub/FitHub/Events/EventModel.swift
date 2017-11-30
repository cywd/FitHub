//
//  EventModel.swift
//  FitHub
//
//  Created by Cyrill on 2017/11/29.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit

class EventModel: NSObject {
    
    var id: Int = 0
    var type: String?
    
    var actor: UserModel?
    var repo: RepositoryModel?
    // -------------------------
    var payload : [String: Any?]?
    var isPublic: Bool = false
    var created_at: String?
    // -----------------------
    var org: OrgModel?
    
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if value == nil { return }
        super.setValue(value, forKey: key)
        if key == "actor" {
            self.actor = UserModel(dict: value as! [String : AnyObject])
        } else if key == "repo" {
            self.repo = RepositoryModel(dict: value as! [String : AnyObject])
        }
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print(key)
        
    }

}
