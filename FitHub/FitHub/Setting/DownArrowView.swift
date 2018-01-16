//
//  DownArrowView.swift
//  FitHub
//
//  Created by cyrill on 2017/12/13.
//  Copyright © 2017年 cyrill.win. All rights reserved.
//

import UIKit

class DownArrowView: UIView {

    var _layerArrow: CAShapeLayer!
    var _startArrowPath: UIBezierPath!
    var _endArrowPath: UIBezierPath!
    
    var ani1: CABasicAnimation!
    
    var isStart = false
    
    // MARK: - public

    func aaa() {
        ani1.fromValue = _startArrowPath.cgPath
        ani1.toValue = _endArrowPath.cgPath
        _layerArrow.add(ani1, forKey: "changePath")
    }
    
    func bbb() {
        ani1.fromValue = _endArrowPath.cgPath
        ani1.toValue = _startArrowPath.cgPath
        _layerArrow.add(ani1, forKey: "changePath")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setup() {
        self.backgroundColor = UIColor.clear
//        self.backgroundColor = UIColor.white
        setupLayer()
        
    }
    
    func setupLayer() {
        _layerArrow = CAShapeLayer()
        _layerArrow.fillColor = UIColor.clear.cgColor
        _layerArrow.strokeColor = UIColor.white.cgColor
        _layerArrow.lineWidth = 3
        _layerArrow.lineCap = kCALineCapRound
        _layerArrow.contentsScale = UIScreen.main.scale
        setPath()
        
        self.layer.addSublayer(_layerArrow)
//        self.layer.mask = _layerArrow
    }
    
    func setPath() {
        let centerX = self.bounds.size.width * 0.5
        let centerY = self.bounds.size.height * 0.5
        
        _startArrowPath = UIBezierPath()
        _startArrowPath.move(to: CGPoint(x: centerX-15, y: centerY-5))
        _startArrowPath.addLine(to: CGPoint(x: centerX, y: centerY+5))
        _startArrowPath.addLine(to: CGPoint(x: centerX+15, y: centerY-5))
        _layerArrow.path = _startArrowPath.cgPath
        
        _endArrowPath = UIBezierPath()
        _endArrowPath.move(to: CGPoint(x: centerX-15, y: centerY))
        _endArrowPath.addLine(to: CGPoint(x: centerX, y: centerY))
        _endArrowPath.addLine(to: CGPoint(x: centerX+15, y: centerY))
        
        ani1 = CABasicAnimation(keyPath: "path")
        ani1.autoreverses = false
        ani1.repeatCount = 1
        ani1.isRemovedOnCompletion = false
        ani1.fillMode = kCAFillModeForwards
        _layerArrow.add(ani1, forKey: "changePath")
    }
}
