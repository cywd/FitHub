//
//  CommentModel.swift
//  FitHub
//
//  Created by Cyrill on 2017/11/30.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit

@objcMembers
class CommentModel: NSObject {
    var id: Int = 0
    var url: String?
    var html_url: String?
    var issue_url: String?
    var user: UserModel?
    var created_at: String?
    var updated_at: String?
    var body: String?

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
        print(key)

    }
    
}
