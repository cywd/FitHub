//
//  FontInfomation.swift
//  FitHub
//
//  Created by cyrill on 2017/12/27.
//  Copyright © 2017年 cyrill.win. All rights reserved.
//

import UIKit

class FontInfomation: NSObject {

    class func systemFontList() -> [String: [String]] {
        let familyNames = UIFont.familyNames
        var systemFontDictionary = [String: [String]]()
        for familyName in familyNames {
            systemFontDictionary[familyName] = UIFont.fontNames(forFamilyName: familyName)
        }
        return systemFontDictionary
    }
    
}
