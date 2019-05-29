//
//  LinkModel.swift
//  FitHub
//
//  Created by cyrill on 2018/1/10.
//  Copyright © 2018年 cyrill.win. All rights reserved.
//

import UIKit

@objcMembers
class LinkModel: NSObject {
    
    var selfStr: String?
    var git: String?
    var html: String?
    
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if value == nil { return }
        super.setValue(value, forKey: key)
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
        
        if key == "self" {
            self.selfStr = value as? String
        }
    }
}
