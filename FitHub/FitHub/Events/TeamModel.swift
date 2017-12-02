//
//  TeamModel.swift
//  FitHub
//
//  Created by Cyrill on 2017/11/30.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit

class TeamModel: NSObject {
    var id: Int = 0
    var name: String?
    var slug: String?
    var permission: String?
    var url: String?
    var members_url: String?
    var repositories_url: String?
    
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
