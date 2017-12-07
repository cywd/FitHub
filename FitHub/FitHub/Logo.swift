//
//  Logo.swift
//  Logo
//
//  Created by cy on 06/12/2017.
//  Copyright © 2017 cyrill.win. All rights reserved.
//
//  Generated by PaintCode
//  http://www.paintcodeapp.com
//



import UIKit

public class Logo : NSObject {

    //// Drawing Methods
    
    @objc public dynamic class func drawDarkLogo(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 430, height: 345), color: UIColor = UIColor(red: 0.103, green: 0.075, blue: 0.068, alpha: 1.000), resizing: ResizingBehavior = .aspectFit) {
        self.drawLogo(frame: targetFrame, color: color, resizing: resizing)
    }
    
    @objc public dynamic class func drawLightLogo(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 430, height: 345), color: UIColor = UIColor.white, resizing: ResizingBehavior = .aspectFit) {
        self.drawLogo(frame: targetFrame, color: color, resizing: resizing)
    }

    @objc public dynamic class func drawLogo(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 430, height: 345), color: UIColor, resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 430, height: 345), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 430, y: resizedFrame.height / 345)


        //// Color Declarations
        let fillColor = color

        //// Group 2
        //// Group 3
        context.saveGState()
        context.beginTransparencyLayer(auxiliaryInfo: nil)

        //// Clip Clip
        let clipPath = UIBezierPath(rect: CGRect(x: -0.02, y: -0.02, width: 429.85, height: 344.9))
        clipPath.addClip()


        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 363.86, y: 290.04))
        bezierPath.addCurve(to: CGPoint(x: 329.4, y: 276.61), controlPoint1: CGPoint(x: 350.64, y: 290.04), controlPoint2: CGPoint(x: 338.39, y: 285.27))
        bezierPath.addCurve(to: CGPoint(x: 318.63, y: 274.67), controlPoint1: CGPoint(x: 326.54, y: 273.84), controlPoint2: CGPoint(x: 322.28, y: 273.07))
        bezierPath.addCurve(to: CGPoint(x: 312.76, y: 283.9), controlPoint1: CGPoint(x: 314.98, y: 276.27), controlPoint2: CGPoint(x: 312.66, y: 279.92))
        bezierPath.addCurve(to: CGPoint(x: 312.86, y: 285.14), controlPoint1: CGPoint(x: 312.77, y: 284.32), controlPoint2: CGPoint(x: 312.8, y: 284.73))
        bezierPath.addCurve(to: CGPoint(x: 266.53, y: 324.25), controlPoint1: CGPoint(x: 312.5, y: 306.76), controlPoint2: CGPoint(x: 291.85, y: 324.25))
        bezierPath.addCurve(to: CGPoint(x: 223.72, y: 299.7), controlPoint1: CGPoint(x: 247.74, y: 324.25), controlPoint2: CGPoint(x: 230.94, y: 314.61))
        bezierPath.addCurve(to: CGPoint(x: 215.64, y: 294.19), controlPoint1: CGPoint(x: 222.19, y: 296.57), controlPoint2: CGPoint(x: 219.12, y: 294.47))
        bezierPath.addCurve(to: CGPoint(x: 206.81, y: 298.37), controlPoint1: CGPoint(x: 212.16, y: 293.92), controlPoint2: CGPoint(x: 208.81, y: 295.51))
        bezierPath.addCurve(to: CGPoint(x: 167.13, y: 317.89), controlPoint1: CGPoint(x: 198.29, y: 310.59), controlPoint2: CGPoint(x: 183.46, y: 317.89))
        bezierPath.addCurve(to: CGPoint(x: 120.95, y: 279.26), controlPoint1: CGPoint(x: 142.34, y: 317.89), controlPoint2: CGPoint(x: 121.62, y: 300.56))
        bezierPath.addCurve(to: CGPoint(x: 114.33, y: 270.28), controlPoint1: CGPoint(x: 120.82, y: 275.19), controlPoint2: CGPoint(x: 118.19, y: 271.61))
        bezierPath.addCurve(to: CGPoint(x: 103.59, y: 273.27), controlPoint1: CGPoint(x: 110.48, y: 268.95), controlPoint2: CGPoint(x: 106.2, y: 270.15))
        bezierPath.addCurve(to: CGPoint(x: 66, y: 290.03), controlPoint1: CGPoint(x: 94.69, y: 283.92), controlPoint2: CGPoint(x: 81, y: 290.03))
        bezierPath.addCurve(to: CGPoint(x: 19.68, y: 250.35), controlPoint1: CGPoint(x: 40.46, y: 290.03), controlPoint2: CGPoint(x: 19.68, y: 272.24))
        bezierPath.addCurve(to: CGPoint(x: 66, y: 210.67), controlPoint1: CGPoint(x: 19.68, y: 228.47), controlPoint2: CGPoint(x: 40.46, y: 210.67))
        bezierPath.addCurve(to: CGPoint(x: 70.61, y: 211.07), controlPoint1: CGPoint(x: 67.58, y: 210.67), controlPoint2: CGPoint(x: 69.09, y: 210.88))
        bezierPath.addLine(to: CGPoint(x: 72.11, y: 211.25))
        bezierPath.addCurve(to: CGPoint(x: 83.51, y: 216.43), controlPoint1: CGPoint(x: 74.18, y: 215.49), controlPoint2: CGPoint(x: 78.96, y: 217.66))
        bezierPath.addCurve(to: CGPoint(x: 90.75, y: 206.21), controlPoint1: CGPoint(x: 88.07, y: 215.2), controlPoint2: CGPoint(x: 91.1, y: 210.91))
        bezierPath.addCurve(to: CGPoint(x: 82.07, y: 197.18), controlPoint1: CGPoint(x: 90.4, y: 201.51), controlPoint2: CGPoint(x: 86.75, y: 197.72))
        bezierPath.addCurve(to: CGPoint(x: 70.45, y: 147.38), controlPoint1: CGPoint(x: 74.36, y: 181.36), controlPoint2: CGPoint(x: 70.45, y: 164.61))
        bezierPath.addCurve(to: CGPoint(x: 216.23, y: 20.02), controlPoint1: CGPoint(x: 70.45, y: 77.16), controlPoint2: CGPoint(x: 135.85, y: 20.02))
        bezierPath.addCurve(to: CGPoint(x: 362.01, y: 147.38), controlPoint1: CGPoint(x: 296.61, y: 20.02), controlPoint2: CGPoint(x: 362.01, y: 77.16))
        bezierPath.addCurve(to: CGPoint(x: 350.51, y: 196.95), controlPoint1: CGPoint(x: 362.01, y: 164.54), controlPoint2: CGPoint(x: 358.14, y: 181.21))
        bezierPath.addCurve(to: CGPoint(x: 351.21, y: 206.73), controlPoint1: CGPoint(x: 348.98, y: 200.1), controlPoint2: CGPoint(x: 349.25, y: 203.83))
        bezierPath.addCurve(to: CGPoint(x: 360.02, y: 211.05), controlPoint1: CGPoint(x: 353.17, y: 209.64), controlPoint2: CGPoint(x: 356.53, y: 211.28))
        bezierPath.addCurve(to: CGPoint(x: 362.3, y: 210.82), controlPoint1: CGPoint(x: 360.79, y: 210.99), controlPoint2: CGPoint(x: 361.54, y: 210.91))
        bezierPath.addCurve(to: CGPoint(x: 363.88, y: 210.67), controlPoint1: CGPoint(x: 362.82, y: 210.75), controlPoint2: CGPoint(x: 363.34, y: 210.67))
        bezierPath.addCurve(to: CGPoint(x: 410.21, y: 250.35), controlPoint1: CGPoint(x: 389.43, y: 210.67), controlPoint2: CGPoint(x: 410.21, y: 228.47))
        bezierPath.addCurve(to: CGPoint(x: 363.86, y: 290.04), controlPoint1: CGPoint(x: 410.21, y: 272.24), controlPoint2: CGPoint(x: 389.41, y: 290.04))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 373.99, y: 191.72))
        bezierPath.addCurve(to: CGPoint(x: 381.66, y: 147.39), controlPoint1: CGPoint(x: 379.07, y: 177.49), controlPoint2: CGPoint(x: 381.67, y: 162.5))
        bezierPath.addCurve(to: CGPoint(x: 216.22, y: 0.37), controlPoint1: CGPoint(x: 381.66, y: 66.32), controlPoint2: CGPoint(x: 307.44, y: 0.37))
        bezierPath.addCurve(to: CGPoint(x: 50.78, y: 147.39), controlPoint1: CGPoint(x: 125, y: 0.37), controlPoint2: CGPoint(x: 50.78, y: 66.32))
        bezierPath.addCurve(to: CGPoint(x: 58.35, y: 191.42), controlPoint1: CGPoint(x: 50.78, y: 162.47), controlPoint2: CGPoint(x: 53.32, y: 177.21))
        bezierPath.addCurve(to: CGPoint(x: 0, y: 250.36), controlPoint1: CGPoint(x: 25.55, y: 194.83), controlPoint2: CGPoint(x: 0, y: 219.96))
        bezierPath.addCurve(to: CGPoint(x: 65.99, y: 309.7), controlPoint1: CGPoint(x: 0, y: 283.08), controlPoint2: CGPoint(x: 29.6, y: 309.7))
        bezierPath.addCurve(to: CGPoint(x: 105.02, y: 298.13), controlPoint1: CGPoint(x: 80.31, y: 309.7), controlPoint2: CGPoint(x: 93.84, y: 305.61))
        bezierPath.addCurve(to: CGPoint(x: 167.13, y: 337.55), controlPoint1: CGPoint(x: 114.03, y: 321.26), controlPoint2: CGPoint(x: 138.33, y: 337.55))
        bezierPath.addCurve(to: CGPoint(x: 213.67, y: 320.12), controlPoint1: CGPoint(x: 184.86, y: 337.55), controlPoint2: CGPoint(x: 201.45, y: 331.21))
        bezierPath.addCurve(to: CGPoint(x: 266.53, y: 343.92), controlPoint1: CGPoint(x: 225.95, y: 334.9), controlPoint2: CGPoint(x: 245.43, y: 343.92))
        bezierPath.addCurve(to: CGPoint(x: 329.89, y: 301.16), controlPoint1: CGPoint(x: 296.52, y: 343.92), controlPoint2: CGPoint(x: 321.9, y: 325.84))
        bezierPath.addCurve(to: CGPoint(x: 363.86, y: 309.71), controlPoint1: CGPoint(x: 340.05, y: 306.74), controlPoint2: CGPoint(x: 351.68, y: 309.71))
        bezierPath.addCurve(to: CGPoint(x: 429.85, y: 250.37), controlPoint1: CGPoint(x: 400.25, y: 309.71), controlPoint2: CGPoint(x: 429.85, y: 283.09))
        bezierPath.addCurve(to: CGPoint(x: 373.99, y: 191.72), controlPoint1: CGPoint(x: 429.85, y: 220.74), controlPoint2: CGPoint(x: 405.58, y: 196.12))
        bezierPath.close()
        fillColor.setFill()
        bezierPath.fill()


        context.endTransparencyLayer()
        context.restoreGState()


        //// Rectangle 2 Drawing
        let rectangle2Path = UIBezierPath(roundedRect: CGRect(x: 179.63, y: 192.9, width: 70.65, height: 19.65), cornerRadius: 9.8)
        fillColor.setFill()
        rectangle2Path.fill()
        
        context.restoreGState()

    }




    @objc public enum ResizingBehavior: Int {
        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case stretch /// The content is stretched to match the entire target rectangle.
        case center /// The content is centered in the target rectangle, but it is NOT resized.

        public func apply(rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }

            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)

            switch self {
                case .aspectFit:
                    scales.width = min(scales.width, scales.height)
                    scales.height = scales.width
                case .aspectFill:
                    scales.width = max(scales.width, scales.height)
                    scales.height = scales.width
                case .stretch:
                    break
                case .center:
                    scales.width = 1
                    scales.height = 1
            }

            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
}