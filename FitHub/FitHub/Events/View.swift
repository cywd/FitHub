//
//  View.swift
//  FitHub
//
//  Created by Cyrill on 2017/12/1.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit

class View: UIView {
    
    override func draw(_ rect: CGRect) {
    
        
        let color = UIColor.red
        color.set()
        //        let path = UIBezierPath()
        
        //        let path = UIBezierPath(rect: CGRect(x: 10, y: 13, width: 20, height: 30))
        
        let path = UIBezierPath(arcCenter: CGPoint(x: 150, y: 150), radius: 20, startAngle: 0, endAngle: CGFloat(Double.pi), clockwise: true)
        
        path.lineWidth = 2.0
        path.lineCapStyle = CGLineCap.round
        path.lineJoinStyle = .miter
        
        //        path.move(to: CGPoint(x: 100, y: 10))
        //        path.addLine(to: CGPoint(x: 150, y: 50))
        //        path.addLine(to: CGPoint(x: 200, y: 10))
        //
        //
        //        path.move(to: CGPoint(x: 200, y: 10))
        //        path.addLine(to: CGPoint(x: 250, y: 50))
        //        path.addLine(to: CGPoint(x: 300, y: 50))
        
        //        path.close()
        
        path.stroke()
        
        //        path.fill()
        
        //        let context = UIGraphics        GetCurrentContext()
        //        context?.setLineCap(CGLineCap.square)
        //        context?.setLineWidth(1.0)
        //        context?.setStrokeColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        //
        //        context?.beginPath()
        //        context?.move(to: CGPoint(x: 100, y: 10))
        //        context?.addLine(to: CGPoint(x: 150, y: 10))
        //        context?.addLine(to: CGPoint(x: 150, y: 60))
        //        context?.addLine(to: CGPoint(x: 100, y: 60))
        //        context?.addLine(to: CGPoint(x: 100, y: 10))
        //        context?.strokePath()
    }
}
