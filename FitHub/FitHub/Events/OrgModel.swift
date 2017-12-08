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

    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }

    override func setValue(_ value: Any?, forKey key: String) {
        if value == nil { return }
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print(key)
    }

}
