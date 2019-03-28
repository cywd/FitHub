//
//  Languages.swift
//  FitHub
//
//  Created by cyrill on 2017/12/28.
//  Copyright © 2017年 cyrill.win. All rights reserved.
//

import UIKit

class Languages: NSObject {
    
    static let data = NSData(contentsOfFile: Bundle.main.path(forResource: "colors", ofType: ".json")!)

    class func colorDict() -> NSDictionary {
        let json = try? JSONSerialization.jsonObject(with: data! as Data, options: []) as? NSDictionary
        return json!
    }
    
    class func languages() -> [String] {
        return self.colorDict().allKeys as! [String]
    }
}
