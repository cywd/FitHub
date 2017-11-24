//
//  UIView+FitHub.swift
//  FitHub
//
//  Created by Cyrill on 2017/11/22.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit

protocol StoryboardLoadable {}

extension StoryboardLoadable where Self: UIViewController {
    
    /// load storyboard
    ///
    /// - Parameter name: storyboardname
    /// - Returns: view
    static func loadStoryboard(name: String? = nil) -> Self {
        let storyboard = UIStoryboard(name: "\(self)", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "\(self)") as! Self
    }
}

protocol LoadNibProtocol {}

extension LoadNibProtocol {
    
    /// load nib
    ///
    /// - Parameter name: nib name [
    /// - Returns: view
    static func loadViewFromNib(name: String?) -> Self {
        return Bundle.main.loadNibNamed(name ?? "\(self)", owner: nil, options: nil)?.last as! Self
    }
}

protocol RegisterCellOrNib {}

extension RegisterCellOrNib {
    static var identifier: String {
        return "\(self)"
    }
    
    static var xib: UINib? {
        return UINib(nibName: "\(self)", bundle: nil)
    }
}

extension UIView {
    /// x
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
        }
    }
    
    /// y
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y    = newValue
            frame                 = tempFrame
        }
    }
    
    /// height
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame                 = tempFrame
        }
    }
    
    /// width
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    
    /// size
    var size: CGSize {
        get {
            return frame.size
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
    
    /// centerX
    var centerX: CGFloat {
        get {
            return center.x
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    /// centerY
    var centerY: CGFloat {
        get {
            return center.y
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y = newValue
            center = tempCenter;
        }
    }
}
