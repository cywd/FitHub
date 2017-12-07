//
//  UIImageView+FitHub.swift
//  FitHub
//
//  Created by Cyrill on 2017/11/22.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit

extension UIImageView {

    /// 将图片变成圆形
    func circleImage() {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        context?.addEllipse(in: self.bounds)
        context?.clip()
        self.draw(self.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        DispatchQueue.global().async {
            self.image = image
        }
    }
}
