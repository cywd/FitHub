//
//  Themes.swift
//  FitHub
//
//  Created by cyrill on 2018/2/23.
//  Copyright © 2018年 cyrill.win. All rights reserved.
//

import Foundation
import UIKit

struct ColorTheme {
    
    static var themeBarStyle = UIBarStyle.black //顶部状态栏的风格
    
    static var themeKeyboardStyle = UIKeyboardAppearance.dark //键盘样式风格
    
    static var themeBackColor: UIColor = UIColor(red: 60/255, green: 64/255, blue: 65/255, alpha: 1)
    
    static var themeFrontColor: UIColor = UIColor.white
    
    static var themeBackgroudColor: UIColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
    
    static var themeBackgroudFrontColor: UIColor = UIColor.gray
    
    static func themeSelect(index: Int) {
        switch index {
        case 0:
            theme0()
        case 1:
            theme1()
        default:
            print("default")
        }
    }
    
    static func theme0() {
        // 主题第0个
    }
    
    static func theme1() {
        // 主题1
    }
    
}
