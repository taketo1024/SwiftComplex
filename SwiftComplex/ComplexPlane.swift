//
//  ComplexPlane.swift
//  SwiftComplex
//
//  Created by Taketo Sano on 2014/10/18.
//  
//

import UIKit

class ComplexPlane : UIView {
    var pointSize: CGFloat = 8.0
    var unit: CGFloat = 50.0
    var scale: CGFloat = 1.0
    var points: [String: Complex] = [:]
    var colors: [String: UIColor] = [:]
    
    subscript(name: String) -> Complex? {
        get {
            return points[name]
        }
        set(value) {
            points[name] = value
        }
    }
    
    func update() {
        self.setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        let centerX = self.bounds.width / 2
        let centerY = self.bounds.height / 2
        
        // fill background
        CGContextSetFillColorWithColor(ctx, UIColor.whiteColor().CGColor)
        CGContextFillRect(ctx, self.bounds)
        
        // draw axises
        CGContextSetLineWidth(ctx, 1)
        CGContextSetStrokeColorWithColor(ctx, UIColor.blackColor().CGColor)
        
        CGContextMoveToPoint(ctx, 0, centerY)
        CGContextAddLineToPoint(ctx, self.bounds.width, centerY)
        CGContextStrokePath(ctx)
        
        CGContextMoveToPoint(ctx, centerX, 0)
        CGContextAddLineToPoint(ctx, centerX, self.bounds.height)
        CGContextStrokePath(ctx)
        
        // draw points
        for (name, z) in points {
            let u = unit / scale
            let point = CGPoint(x: centerX + u * CGFloat(z.x), y: centerY - u * CGFloat(z.y))
            let color = (colors[name] != nil) ? colors[name]! : UIColor.blackColor()
            
            // draw point
            CGContextSetFillColorWithColor(ctx, color.CGColor)
            CGContextAddArc(ctx, point.x, point.y, pointSize / 2, 0, CGFloat(2 * M_PI), 0)
            CGContextFillPath(ctx)
            
            // draw name
            let text: NSString = name
            let textPoint = CGPoint(x: point.x + 5, y: point.y)
            text.drawAtPoint(textPoint, withAttributes:[NSForegroundColorAttributeName: color])
        }
    }
    
    func complexAtPoint(point: CGPoint) -> Complex {
        let u = unit / scale
        let centerX = self.bounds.width / 2
        let centerY = self.bounds.height / 2
        
        return Complex(Double((point.x - centerX) / u), -Double((point.y - centerY) / u))
    }
}