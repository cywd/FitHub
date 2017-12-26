//
//  FitHud.swift
//  FitHub
//
//  Created by cyrill on 2017/12/22.
//  Copyright © 2017年 cyrill.win. All rights reserved.
//

import UIKit

private var hud: FitHud?

class FitHud {
    open var hudBackgroundView: UIView { get { return self._hudBackgroundView } }
    fileprivate(set) var _hudBackgroundView: UIView
    open var loadingView: FitHudView? { get { return self._loadingView } }
    fileprivate(set) var _loadingView: FitHudView
    
    open class func show() -> FitHud {
        let view: UIView? = UIApplication.shared.keyWindow?.rootViewController?.view
        assert(view != nil, "must init window rootViewController")
        return self.show(view: view!)
    }
    
    open class func show(view: UIView) -> FitHud {
        return self.show(view: view, after: 0)
    }
    
    open class func show(view: UIView, after: TimeInterval) -> FitHud {
        return FitHud(view: view, after: after)
    }
    
    open func hide() {
        return self.hide(after: 0)
    }
    
    open func hide(after: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(after * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
            UIView.animate(withDuration: 1, animations: {
                self._hudBackgroundView.alpha = 0
            }, completion: { (completion) in
                self.hudBackgroundView.removeFromSuperview()
            })
        })
    }
    
    required public init(view: UIView, after: TimeInterval) {
        
        if hud != nil && hud!.hudBackgroundView.superview != nil {
            hud!.hudBackgroundView.removeFromSuperview()
        }
        
//        let screenWidth = UIScreen.main.bounds.width
//        let screenHeight = UIScreen.main.bounds.height
//        let width = view.bounds.width
//        let height = view.bounds.height
//
//        var centerX = width / 2
//        var centerY = height / 2
//
//        if width < screenWidth {
//            let margin = screenWidth - width
//            centerX -= margin/2
//        }
//
//        if height < screenHeight {
//            let margin = screenHeight - height
//            centerY -= margin/2
//        }
        
        self._hudBackgroundView = UIView(frame: view.bounds)
//        self._hudBackgroundView.backgroundColor = UIColor(white: 0, alpha: 1)
        self._hudBackgroundView.backgroundColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        self._hudBackgroundView.layer.masksToBounds = true
//        self._hudBackgroundView.layer.cornerRadius = 5
        view.addSubview(self._hudBackgroundView)
        
        self._loadingView = FitHudView(frame: CGRect(x: view.bounds.size.width/2, y: view.bounds.size.height/2, width: 100, height: 100))
//        self._loadingView.center = CGPoint(x: centerX, y:centerY)
        self._loadingView.center = self._hudBackgroundView.center
        self._hudBackgroundView.addSubview(self._loadingView)
        
        if after > 0 {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(after * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
                self.hide()
            })
        }
        
        hud = self
    }
    
}

class FitHudView: UIView {

    var backLayer = CAShapeLayer()
    var graLayer: CAGradientLayer!
    var index = 1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        let path = self.logoPath()
        backLayer.frame = self.bounds
//        backLayer.lineWidth = 8
//        backLayer.fillColor = UIColor.white.cgColor;
//        backLayer.strokeColor = UIColor.blue.cgColor
//        backLayer.lineCap = kCALineCapRound
//        backLayer.lineJoin = kCALineJoinRound
        backLayer.path = path.cgPath
//        self.layer.addSublayer(backLayer)
        
        
        let gradientLayer = CAGradientLayer()
        let randomColor = UIColor.randomColor().cgColor
        gradientLayer.colors = [randomColor, UIColor.white.cgColor, randomColor]
        gradientLayer.frame = self.bounds
        gradientLayer.locations = [-0.2, -0.1, 0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        self.graLayer = gradientLayer
        gradientLayer.mask = backLayer
        self.layer.addSublayer(gradientLayer)
        
        let timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(change), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    @objc func change(){
        index += 1
        if (index % 2) == 0 {
            let animation = CABasicAnimation(keyPath: "locations")
            animation.fromValue = [-0.1, -0.15, 0]
            animation.toValue = [1.0, 1.1, 1.15]
            animation.duration = 0.5
            self.graLayer.add(animation, forKey: "locationsAnim")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func logoPath() -> UIBezierPath {
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: SCPoint(x: 363.86, y: 290.04))
        bezierPath.addCurve(to: SCPoint(x: 329.4, y: 276.61), controlPoint1: SCPoint(x: 350.64, y: 290.04), controlPoint2: SCPoint(x: 338.39, y: 285.27))
        bezierPath.addCurve(to: SCPoint(x: 318.63, y: 274.67), controlPoint1: SCPoint(x: 326.54, y: 273.84), controlPoint2: SCPoint(x: 322.28, y: 273.07))
        bezierPath.addCurve(to: SCPoint(x: 312.76, y: 283.9), controlPoint1: SCPoint(x: 314.98, y: 276.27), controlPoint2: SCPoint(x: 312.66, y: 279.92))
        bezierPath.addCurve(to: SCPoint(x: 312.86, y: 285.14), controlPoint1: SCPoint(x: 312.77, y: 284.32), controlPoint2: SCPoint(x: 312.8, y: 284.73))
        bezierPath.addCurve(to: SCPoint(x: 266.53, y: 324.25), controlPoint1: SCPoint(x: 312.5, y: 306.76), controlPoint2: SCPoint(x: 291.85, y: 324.25))
        bezierPath.addCurve(to: SCPoint(x: 223.72, y: 299.7), controlPoint1: SCPoint(x: 247.74, y: 324.25), controlPoint2: SCPoint(x: 230.94, y: 314.61))
        bezierPath.addCurve(to: SCPoint(x: 215.64, y: 294.19), controlPoint1: SCPoint(x: 222.19, y: 296.57), controlPoint2: SCPoint(x: 219.12, y: 294.47))
        bezierPath.addCurve(to: SCPoint(x: 206.81, y: 298.37), controlPoint1: SCPoint(x: 212.16, y: 293.92), controlPoint2: SCPoint(x: 208.81, y: 295.51))
        bezierPath.addCurve(to: SCPoint(x: 167.13, y: 317.89), controlPoint1: SCPoint(x: 198.29, y: 310.59), controlPoint2: SCPoint(x: 183.46, y: 317.89))
        bezierPath.addCurve(to: SCPoint(x: 120.95, y: 279.26), controlPoint1: SCPoint(x: 142.34, y: 317.89), controlPoint2: SCPoint(x: 121.62, y: 300.56))
        bezierPath.addCurve(to: SCPoint(x: 114.33, y: 270.28), controlPoint1: SCPoint(x: 120.82, y: 275.19), controlPoint2: SCPoint(x: 118.19, y: 271.61))
        bezierPath.addCurve(to: SCPoint(x: 103.59, y: 273.27), controlPoint1: SCPoint(x: 110.48, y: 268.95), controlPoint2: SCPoint(x: 106.2, y: 270.15))
        bezierPath.addCurve(to: SCPoint(x: 66, y: 290.03), controlPoint1: SCPoint(x: 94.69, y: 283.92), controlPoint2: SCPoint(x: 81, y: 290.03))
        bezierPath.addCurve(to: SCPoint(x: 19.68, y: 250.35), controlPoint1: SCPoint(x: 40.46, y: 290.03), controlPoint2: SCPoint(x: 19.68, y: 272.24))
        bezierPath.addCurve(to: SCPoint(x: 66, y: 210.67), controlPoint1: SCPoint(x: 19.68, y: 228.47), controlPoint2: SCPoint(x: 40.46, y: 210.67))
        bezierPath.addCurve(to: SCPoint(x: 70.61, y: 211.07), controlPoint1: SCPoint(x: 67.58, y: 210.67), controlPoint2: SCPoint(x: 69.09, y: 210.88))
        bezierPath.addLine(to: SCPoint(x: 72.11, y: 211.25))
        bezierPath.addCurve(to: SCPoint(x: 83.51, y: 216.43), controlPoint1: SCPoint(x: 74.18, y: 215.49), controlPoint2: SCPoint(x: 78.96, y: 217.66))
        bezierPath.addCurve(to: SCPoint(x: 90.75, y: 206.21), controlPoint1: SCPoint(x: 88.07, y: 215.2), controlPoint2: SCPoint(x: 91.1, y: 210.91))
        bezierPath.addCurve(to: SCPoint(x: 82.07, y: 197.18), controlPoint1: SCPoint(x: 90.4, y: 201.51), controlPoint2: SCPoint(x: 86.75, y: 197.72))
        bezierPath.addCurve(to: SCPoint(x: 70.45, y: 147.38), controlPoint1: SCPoint(x: 74.36, y: 181.36), controlPoint2: SCPoint(x: 70.45, y: 164.61))
        bezierPath.addCurve(to: SCPoint(x: 216.23, y: 20.02), controlPoint1: SCPoint(x: 70.45, y: 77.16), controlPoint2: SCPoint(x: 135.85, y: 20.02))
        bezierPath.addCurve(to: SCPoint(x: 362.01, y: 147.38), controlPoint1: SCPoint(x: 296.61, y: 20.02), controlPoint2: SCPoint(x: 362.01, y: 77.16))
        bezierPath.addCurve(to: SCPoint(x: 350.51, y: 196.95), controlPoint1: SCPoint(x: 362.01, y: 164.54), controlPoint2: SCPoint(x: 358.14, y: 181.21))
        bezierPath.addCurve(to: SCPoint(x: 351.21, y: 206.73), controlPoint1: SCPoint(x: 348.98, y: 200.1), controlPoint2: SCPoint(x: 349.25, y: 203.83))
        bezierPath.addCurve(to: SCPoint(x: 360.02, y: 211.05), controlPoint1: SCPoint(x: 353.17, y: 209.64), controlPoint2: SCPoint(x: 356.53, y: 211.28))
        bezierPath.addCurve(to: SCPoint(x: 362.3, y: 210.82), controlPoint1: SCPoint(x: 360.79, y: 210.99), controlPoint2: SCPoint(x: 361.54, y: 210.91))
        bezierPath.addCurve(to: SCPoint(x: 363.88, y: 210.67), controlPoint1: SCPoint(x: 362.82, y: 210.75), controlPoint2: SCPoint(x: 363.34, y: 210.67))
        bezierPath.addCurve(to: SCPoint(x: 410.21, y: 250.35), controlPoint1: SCPoint(x: 389.43, y: 210.67), controlPoint2: SCPoint(x: 410.21, y: 228.47))
        bezierPath.addCurve(to: SCPoint(x: 363.86, y: 290.04), controlPoint1: SCPoint(x: 410.21, y: 272.24), controlPoint2: SCPoint(x: 389.41, y: 290.04))
        bezierPath.close()
        bezierPath.move(to: SCPoint(x: 373.99, y: 191.72))
        bezierPath.addCurve(to: SCPoint(x: 381.66, y: 147.39), controlPoint1: SCPoint(x: 379.07, y: 177.49), controlPoint2: SCPoint(x: 381.67, y: 162.5))
        bezierPath.addCurve(to: SCPoint(x: 216.22, y: 0.37), controlPoint1: SCPoint(x: 381.66, y: 66.32), controlPoint2: SCPoint(x: 307.44, y: 0.37))
        bezierPath.addCurve(to: SCPoint(x: 50.78, y: 147.39), controlPoint1: SCPoint(x: 125, y: 0.37), controlPoint2: SCPoint(x: 50.78, y: 66.32))
        bezierPath.addCurve(to: SCPoint(x: 58.35, y: 191.42), controlPoint1: SCPoint(x: 50.78, y: 162.47), controlPoint2: SCPoint(x: 53.32, y: 177.21))
        bezierPath.addCurve(to: SCPoint(x: 0, y: 250.36), controlPoint1: SCPoint(x: 25.55, y: 194.83), controlPoint2: SCPoint(x: 0, y: 219.96))
        bezierPath.addCurve(to: SCPoint(x: 65.99, y: 309.7), controlPoint1: SCPoint(x: 0, y: 283.08), controlPoint2: SCPoint(x: 29.6, y: 309.7))
        bezierPath.addCurve(to: SCPoint(x: 105.02, y: 298.13), controlPoint1: SCPoint(x: 80.31, y: 309.7), controlPoint2: SCPoint(x: 93.84, y: 305.61))
        bezierPath.addCurve(to: SCPoint(x: 167.13, y: 337.55), controlPoint1: SCPoint(x: 114.03, y: 321.26), controlPoint2: SCPoint(x: 138.33, y: 337.55))
        bezierPath.addCurve(to: SCPoint(x: 213.67, y: 320.12), controlPoint1: SCPoint(x: 184.86, y: 337.55), controlPoint2: SCPoint(x: 201.45, y: 331.21))
        bezierPath.addCurve(to: SCPoint(x: 266.53, y: 343.92), controlPoint1: SCPoint(x: 225.95, y: 334.9), controlPoint2: SCPoint(x: 245.43, y: 343.92))
        bezierPath.addCurve(to: SCPoint(x: 329.89, y: 301.16), controlPoint1: SCPoint(x: 296.52, y: 343.92), controlPoint2: SCPoint(x: 321.9, y: 325.84))
        bezierPath.addCurve(to: SCPoint(x: 363.86, y: 309.71), controlPoint1: SCPoint(x: 340.05, y: 306.74), controlPoint2: SCPoint(x: 351.68, y: 309.71))
        bezierPath.addCurve(to: SCPoint(x: 429.85, y: 250.37), controlPoint1: SCPoint(x: 400.25, y: 309.71), controlPoint2: SCPoint(x: 429.85, y: 283.09))
        bezierPath.addCurve(to: SCPoint(x: 373.99, y: 191.72), controlPoint1: SCPoint(x: 429.85, y: 220.74), controlPoint2: SCPoint(x: 405.58, y: 196.12))
        bezierPath.close()

        return bezierPath
    }

    fileprivate func SCPoint(x: CGFloat, y: CGFloat) -> CGPoint {
        let scale = self.width <= self.height ? (self.width / 430.0) : (self.height / 345.0)
        return CGPoint(x: x*scale, y: y*scale)
    }
}
