//
//  FitBadgeView.swift
//  FitHub
//
//  Created by cyrill on 2018/2/7.
//  Copyright © 2018年 cyrill.win. All rights reserved.
//

import UIKit

class FitBadgeView: UIView {

    // MARK: - public
    var badgeValue: String! {
        didSet {
            self.frame = self.badgeFrame(withStr: badgeValue)
            self.setNeedsDisplay()
        }
    }
    
    class func view(withBadgeTio badge: String?) -> FitBadgeView? {
        if let badgeValue = badge {
            if badgeValue.count == 0 { return nil }
            
            let badgeView = FitBadgeView()
            badgeView.frame = badgeView.badgeFrame(withStr: badgeValue)
            badgeView.badgeValue = badgeValue
            
            return badgeView
            
        } else {
            return nil
        }
    }
    
    class func badgeSize(withStr badge: String?, font: UIFont = UIFont.systemFont(ofSize: 11)) -> CGSize {
        if let badgeValue = badge {
            if badgeValue.count == 0 { return CGSize.zero }
            
            let str = NSString(string: badgeValue)
            var size = str.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 20), options: NSStringDrawingOptions.truncatesLastVisibleLine.union(.usesLineFragmentOrigin).union(.usesFontLeading) , attributes: [NSAttributedStringKey.font: font], context: nil).size
            if size.width < size.height {
                size.width = size.height
            }
            
            if badgeValue == "badgeTip" {
                size = CGSize(width: 4, height: 4)
            }
            return size
        } else {
            return CGSize.zero
        }
    }
    
    // MARK: - private
    var badgeBackgroundColor: UIColor = UIColor(hexString: "0xf75388")
    var badgeTextColor: UIColor = .white
    var badgeTextFont: UIFont = UIFont.systemFont(ofSize: 11)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        
        // draw code
        // draw badges
        if self.badgeValue.count > 0 {
            let badgeSize = FitBadgeView.badgeSize(withStr: self.badgeValue)
            let badgeBackgroundFrame = CGRect(x: 2, y: 2, width: badgeSize.width + 2 * 2, height: badgeSize.height + 2 * 2)
            let badgeBackgroundPaddingFrame = CGRect(x: 2, y: 2, width: badgeBackgroundFrame.size.width + 2 * 2, height: badgeBackgroundFrame.size.height + 2 * 2)
            
            if self.badgeValue != "badgeTip" {
                // 外白色描边
                context?.setFillColor(UIColor.white.cgColor)
                
                if badgeSize.width > badgeSize.height {
                    let circleWidth = badgeBackgroundPaddingFrame.size.height
                    let totalWidth = badgeBackgroundPaddingFrame.size.width
                    let diffWidth = totalWidth - circleWidth
                    let originPoint = badgeBackgroundPaddingFrame.origin
                    
                    let leftCircleFrame = CGRect(x: originPoint.x, y: originPoint.y, width: circleWidth, height: circleWidth)
                    let centerFrame = CGRect(x: originPoint.x + circleWidth/2, y: originPoint.y, width: diffWidth, height: circleWidth)
                    let rightCircleFrame = CGRect(x: originPoint.x+(totalWidth - circleWidth), y: originPoint.y, width: circleWidth, height: circleWidth)
                    context?.fillEllipse(in: leftCircleFrame)
                    context?.fill(centerFrame)
                    context?.fillEllipse(in: rightCircleFrame)
                } else {
                    context?.fillEllipse(in: badgeBackgroundPaddingFrame)
                }
                
            }
            
            // badge背景色
            context?.setFillColor(self.badgeBackgroundColor.cgColor)
            
            if badgeSize.width > badgeSize.height {
                let circleWidth = badgeBackgroundFrame.size.height
                let totalWidth = badgeBackgroundFrame.size.width
                let diffWidth = totalWidth - circleWidth
                let originPoint = badgeBackgroundFrame.origin
                
                let leftCircleFrame = CGRect(x: originPoint.x, y: originPoint.y, width: circleWidth, height: circleWidth)
                let centerFrame = CGRect(x: originPoint.x + circleWidth/2, y: originPoint.y, width: diffWidth, height: circleWidth)
                let rightCircleFrame = CGRect(x: originPoint.x+(totalWidth - circleWidth), y: originPoint.y, width: circleWidth, height: circleWidth)
                context?.fillEllipse(in: leftCircleFrame)
                context?.fill(centerFrame)
                context?.fillEllipse(in: rightCircleFrame)
            } else {
                context?.fillEllipse(in: badgeBackgroundFrame)
            }
            
            if self.badgeValue != "badgeTip" {
                // 外白色描边
                context?.setFillColor(self.badgeTextColor.cgColor)
                
                let badgeTextStyle = NSMutableParagraphStyle()
                badgeTextStyle.lineBreakMode = .byWordWrapping
                badgeTextStyle.alignment = .center
                
                NSString(string: self.badgeValue).draw(in: CGRect(x: badgeBackgroundFrame.minX+2, y: badgeBackgroundFrame.minY+2, width: badgeSize.width, height: badgeSize.height), withAttributes: [NSAttributedStringKey.font: self.badgeTextFont, NSAttributedStringKey.foregroundColor: self.badgeTextColor, NSAttributedStringKey.paragraphStyle: badgeTextStyle])
            }
        }
        context?.restoreGState()
    }
    
    private func badgeFrame(withStr badge: String) -> CGRect {
        let badgeSize = FitBadgeView.badgeSize(withStr: badge)
        return CGRect(x: 0, y: 0, width: badgeSize.width + 8, height: badgeSize.height + 8)
    }
    
}
