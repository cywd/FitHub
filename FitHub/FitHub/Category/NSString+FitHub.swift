//
//  NSString+FitHub.swift
//  FitHub
//
//  Created by cyrill on 2017/12/26.
//  Copyright © 2017年 cyrill.win. All rights reserved.
//

import Foundation
import UIKit

extension NSString {
    
    func height(font: UIFont = UIFont.systemFont(ofSize: 18.0), labelWidth: CGFloat) -> CGFloat {
        var height: CGFloat = 0.0
        if self.length == 0 {
            height = 0.0
        } else {
            let size = self.boundingRect(with: CGSize(width: labelWidth, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.truncatesLastVisibleLine.union(.usesLineFragmentOrigin).union(.usesFontLeading) , attributes: [NSAttributedStringKey.font: font], context: nil).size
            height = size.height
        }
        return CGFloat(height)
    }
    
    func width(font: UIFont = UIFont.systemFont(ofSize: 18.0)) -> CGFloat {
        var width: CGFloat = 0.0
        if self.length == 0 {
            width = 0.0
        } else {
            let size = self.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 0), options: NSStringDrawingOptions.truncatesLastVisibleLine.union(.usesLineFragmentOrigin).union(.usesFontLeading) , attributes: [NSAttributedStringKey.font: font], context: nil).size
            width = size.width
        }
        return CGFloat(width)
    }
}
