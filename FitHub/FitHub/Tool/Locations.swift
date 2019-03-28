//
//  Locations.swift
//  FitHub
//
//  Created by cyrill on 2018/9/20.
//  Copyright © 2018年 cyrill.win. All rights reserved.
//

import UIKit

class Locations: NSObject {
    
    static let data = NSData(contentsOfFile: Bundle.main.path(forResource: "location", ofType: ".json")!)

    class func locationArray() -> NSArray {
        let json = try? JSONSerialization.jsonObject(with: data! as Data, options: [])
        return json as! NSArray
    }
    
    class func locations() -> [String] {
        return self.locationArray().value(forKeyPath: "country") as! [String]
    }
}
