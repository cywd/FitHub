//
//  String+QueryItemValue.swift
//  FitHub
//
//  Created by cyrill on 2018/1/10.
//  Copyright © 2018年 cyrill.win. All rights reserved.
//

import Foundation

extension String {
    
    func valueForQuery(key: String) -> String? {
        guard let items = URLComponents(string: self)?.queryItems else { return nil }
        for item in items where item.name == key {
            return item.value
        }
        return nil
    }
    
    /// 从String中截取出参数
    var onlyParameters: [String: AnyObject]? {
        
        var params = [String: AnyObject]()
        
        let paramsString = self
        
        // 判断参数是单个参数还是多个参数
        if paramsString.contains("&") {
            
            // 多个参数，分割参数
            let urlComponents = paramsString.split(separator: "&")
            
            // 遍历参数
            for keyValuePair in urlComponents {
                // 生成Key/Value
                let pairComponents = keyValuePair.split(separator: "=")
                let key = pairComponents.first?.removingPercentEncoding
                let value = pairComponents.last?.removingPercentEncoding
                // 判断参数是否是数组
                if let key = key, let value = value {
                    // 已存在的值，生成数组
                    if let existValue = params[key] {
                        if var existValue = existValue as? [AnyObject] {
                            
                            existValue.append(value as AnyObject)
                        } else {
                            params[key] = [existValue, value] as AnyObject
                        }
                        
                    } else {
                        
                        params[key] = value as AnyObject
                    }
                    
                }
            }
            
        }
        
        return params
    }
}
