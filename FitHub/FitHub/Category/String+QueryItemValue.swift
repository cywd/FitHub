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
    
}
