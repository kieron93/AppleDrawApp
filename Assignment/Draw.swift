//
//  Draw.swift
//  Assignment
//
//  Created by Student on 28/11/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit

var Red : CGFloat = 0.0
var Green : CGFloat = 0.0
var Blue : CGFloat = 0.0
var Alpha : CGFloat = 1.0

var image : CGImage?

var clear : Bool = false

class Draw: UIView
{
    var startX : CGFloat = 0.0
    var startY : CGFloat = 0.0
    var context : CGContext?
    var erase : Bool = false
    
    override func draw(_ rect: CGRect)
    {
        let context = UIGraphicsGetCurrentContext()
        
        if image != nil
        {
            context?.draw(image!, in:CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.width, height: self.bounds.height))
        }
        
    }
    
    func eraser()
    {
        switch erase {
        case true:
            erase = false
            break
        case false:
            erase = true
            break
        default:
            break
        }
    }
    
    func clear()
    {
        //var sX : Int = 0
        //var sY : Int = 0
        for i in 1...Int(self.bounds.height*2)
        {
            context!.setLineWidth(2.0)
            context!.setStrokeColor(UIColor.white.cgColor)
            context?.move(to: CGPoint(x:0,y:i))
            context?.addLine(to: CGPoint(x:(Int(self.bounds.width*2)), y:i))
            //print()
            context?.strokePath()
            image = context!.makeImage()
        }
        setNeedsDisplay()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        super.touchesBegan(touches, with: event)
        
        for touch : AnyObject in touches
        {
            let p = touch.location(in: self.superview)
            startX = p.x - 20
            startY = p.y - 20
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with:event)
        var endX : CGFloat = 0.0
        var endY : CGFloat = 0.0
        
        for touch : AnyObject in touches
        {
            let p = touch.location(in: self.superview)
            
            endX = p.x - 20
            endY = p.y - 20
        }
        let w = self.bounds.width
        let h = self.bounds.height
        
        if image == nil {
            let colorSpace : CGColorSpace = CGColorSpaceCreateDeviceRGB()
            let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
            context = CGContext(data: nil, width: Int(w*2), height: Int(h*2),bitsPerComponent: 8, bytesPerRow: Int(w*4*2), space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        }
        
        if erase == false {
            context!.setLineWidth(2.0)
            context!.setStrokeColor(red: Red/256.0, green: Green/256.0, blue: Blue/256.0, alpha: Alpha)
            context?.move(to: CGPoint(x:CGFloat(startX*2),y:CGFloat(startY*2)))
            context?.addLine(to: CGPoint(x:CGFloat(endX*2), y:CGFloat(endY*2)))
            context?.strokePath()
        }
        else {
            context!.setLineWidth(50.0)
            context!.setStrokeColor(red: 255.0, green: 255.0, blue: 255.0, alpha: Alpha)
            context?.move(to: CGPoint(x:CGFloat(startX*2),y:CGFloat(startY*2)))
            context?.addLine(to: CGPoint(x:CGFloat(endX*2), y:CGFloat(endY*2)))
            context?.strokePath()
        }
        
        startX = endX
        startY = endY
        
        image = context!.makeImage()
        
        setNeedsDisplay()
    }

}
