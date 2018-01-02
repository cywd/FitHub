//
//  String+FitHub.swift
//  FitHub
//
//  Created by cyrill on 2018/1/2.
//  Copyright © 2018年 cyrill.win. All rights reserved.
//

import Foundation

extension String {
    public func substring(from index: Int) -> String {
        if self.count > index {
            let startIndex = self.index(self.startIndex, offsetBy: index)
            let subString = self[startIndex..<self.endIndex]
            
            return String(subString)
        } else {
            return self
        }
    }
}
