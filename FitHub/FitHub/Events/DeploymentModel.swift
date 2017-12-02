//
//  DeploymentModel.swift
//  FitHub
//
//  Created by Cyrill on 2017/11/30.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit

class DeploymentModel: NSObject {
    var id: Int = 0
    var url: String?
    var sha: String?
    var ref: String?
    var task: String?
    var environment: String?
    var desc: String?
    var created_at: String?
    var updated_at: String?
    var statuses_url: String?
    var repository_url: String?
    var payload: String?
    var creator: UserModel?
    
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if value == nil { return }
        super.setValue(value, forKey: key)
        if key == "creator" {
            self.creator = UserModel(dict: value as! [String : AnyObject])
        }
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print(key)
        
        if key == "description" {
            self.desc = value as? String
        }
    }

}

class DeploymentStatusModel: NSObject {
    var id: Int = 0
    var url: String?
    var state: String?
    var desc: String?
    var target_url: String?
    var created_at: String?
    var updated_at: String?
    var repository_url: String?
    var deployment_url: String?
    var creator: UserModel?
    
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if value == nil { return }
        super.setValue(value, forKey: key)
        if key == "creator" {
            self.creator = UserModel(dict: value as! [String : AnyObject])
        }
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print(key)
        
        if key == "description" {
            self.desc = value as? String
        }
    }
    
}
