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
    
    // MARK: - public
    public func startAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "path")
        animation.values = [_startArrowPath.cgPath,  _endArrowPath.cgPath, _endArrowPath.cgPath]
        animation.keyTimes = [0.45, 0.75, 0.95]
        animation.autoreverses = true
        animation.repeatCount = 1
        animation.duration = 1
        
        _layerArrow.add(animation, forKey: "changePath")
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
        _endArrowPath.move(to: CGPoint(x: centerX-15, y: centerY+5))
        _endArrowPath.addLine(to: CGPoint(x: centerX, y: centerY-5))
        _endArrowPath.addLine(to: CGPoint(x: centerX+15, y: centerY+5))
    }
}
