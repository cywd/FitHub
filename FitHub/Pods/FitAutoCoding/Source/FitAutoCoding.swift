//
//  FitAutoCoding.swift
//  FitHub
//
//  Created by cyrill on 2018/1/12.
//  Copyright © 2018年 cyrill.win. All rights reserved.
//

import Foundation

extension NSObject {
    
    func codableProperties() -> Dictionary<String, Any?> {
        var codableProperties = [String: Any?]()
        let mirrorOfSelf = Mirror(reflecting: self)
        
        for item in mirrorOfSelf.children {
            if let label = item.label {
                codableProperties[label] = unwrap(item.value)
            }
        }
        return codableProperties
    }
    
    func unwrap(_ any: Any) -> Any? {
        let mi = Mirror(reflecting: any)
        if mi.displayStyle != Mirror.DisplayStyle.optional {
            return any
        }
        if mi.children.count == 0 { return nil } // Optional.None
        return mi.children.first?.value
    }
    
    public func setup(withDecoder aDecoder: NSCoder) {
        for (key, _) in codableProperties() {
            let object = aDecoder.decodeObject(forKey: key)
            setValue(object, forKey: key)
        }
    }
    
    public func setup(withCoder aCoder: NSCoder) {
        for (key, value) in codableProperties() {
            switch value {
            case let property as AnyObject:
                aCoder.encode(property, forKey: key)
            case let property as Int:
                aCoder.encode(Int64(property), forKey: key)
            case let property as Bool:
                aCoder.encode(property, forKey: key)
            default:
                print("Nil value for \(key)")
            }
        }
    }
}

