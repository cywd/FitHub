//
//  DownArrowView.swift
//  FitHub
//
//  Created by cyrill on 2017/12/13.
//  Copyright © 2017年 cyrill.win. All rights reserved.
//

import UIKit

class DownArrowView: UIView {

    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(#colorLiteral(red: 0.2666336298, green: 0.2666856647, blue: 0.2666303515, alpha: 1))
        context?.fill(rect)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(2.0)
        context?.setStrokeColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))

        let width = rect.size.width
        let height = rect.size.height
        
        context?.beginPath()
        context?.move(to: CGPoint(x: 1, y: 1))
        context?.addLine(to: CGPoint(x: width*0.5, y: height-2))
        context?.addLine(to: CGPoint(x: width-2, y: 1))
        context?.strokePath()
        
    }
}
