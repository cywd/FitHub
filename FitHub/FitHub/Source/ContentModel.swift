//
//  ContentModel.swift
//  FitHub
//
//  Created by cyrill on 2018/1/10.
//  Copyright © 2018年 cyrill.win. All rights reserved.
//

import UIKit

@objcMembers
class ContentModel: NSObject {
    
    var name: String?
    var path: String?
    var sha: UserModel?
    var size: Int = 0
    var url: String?
    var html_url: String?
    var git_url: String?
    var download_url: String?
    var type: String? {
        didSet {
            self.isDirectory = (self.type == "dir")
        }
    }
    var _link: LinkModel?
    
    var isDirectory: Bool = false
    
    
    // readme
    var content: String?
    var encoding: String?
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if value == nil { return }
        super.setValue(value, forKey: key)
        if key == "_link" {
            self._link = LinkModel(dict: value as! [String : AnyObject])
        }
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print(key)
    }
}
