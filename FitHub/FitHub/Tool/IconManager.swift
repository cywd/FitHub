//
//  IconManager.swift
//  FitHub
//
//  Created by cyrill on 2018/2/22.
//  Copyright © 2018年 cyrill.win. All rights reserved.
//

import UIKit

class IconManager: NSObject {

    class func changeIcon(iconName: String?) {
        if #available(iOS 10.3, *) {
            if UIApplication.shared.supportsAlternateIcons {
                // 判断设备是否支持更换图标
                print("支持更换图标")
                
                UIApplication.shared.setAlternateIconName(iconName, completionHandler: { (error) in
                    if let _ = error {
                        print("替换图标失败\(String(describing: error?.localizedDescription))")
                    }
                })
                
            } else {
                print("不支持更换图标")
            }
        } else {
            print("更早的系统版本，不支持更换图标")
        }
    }
}
