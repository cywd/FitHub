//
//  LicenseModel.swift
//  FitHub
//
//  Created by cyrill on 2018/1/9.
//  Copyright © 2018年 cyrill.win. All rights reserved.
//

import UIKit

@objcMembers
class LicenseModel: NSObject {
    
    var key: String?
    var name: String?
    var spdx_id: String?
    var url: String?
    var html_url: String?
    var desc: String?
    
    var implementation: String?
    var permissions: [String]?
    var conditions: [String]?
    var limitations: [String]?
    var body: String?
    var featured: Bool = false
    
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
        
        if key == "description" {
            self.desc = value as? String
        }
    }
}
