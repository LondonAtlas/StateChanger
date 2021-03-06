//
//  StyleKit.swift
//  Kevo
//
//  Created by Tom Marks on 10/03/2016.
//  Copyright (c) 2016 UniKey. All rights reserved.
//
//  Generated by PaintCode (www.paintcodeapp.com)
//



import UIKit

public class StyleKit : NSObject {

    //// Cache

    private struct Cache {
        static let errorColor: UIColor = UIColor(red: 0.800, green: 0.320, blue: 0.320, alpha: 1.000)
        static let successColor: UIColor = UIColor(red: 0.652, green: 0.800, blue: 0.320, alpha: 1.000)
        static let warningColor: UIColor = UIColor(red: 0.903, green: 0.779, blue: 0.068, alpha: 1.000)
    }

    //// Colors

    public class var errorColor: UIColor { return Cache.errorColor }
    public class var successColor: UIColor { return Cache.successColor }
    public class var warningColor: UIColor { return Cache.warningColor }

    //// Drawing Methods

    public class func drawProgressButton(frame frame: CGRect = CGRectMake(0, 0, 200, 200), rotationAngle: CGFloat = 2, progress: CGFloat = 0.721, state: CGFloat = 0) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()


        //// Variable Declarations
        let textTernary = state == 0 ? "Success" : (state == 1 ? "Error" : "Warning")
        let backgroundColouring = state == 0 ? StyleKit.successColor : (state == 1 ? StyleKit.errorColor : StyleKit.warningColor)


        //// Subframes
        let group2: CGRect = CGRectMake(frame.minX + floor(frame.width * 0.00000 + 0.5), frame.minY + floor(frame.height * 0.00000 + 0.5), floor(frame.width * 1.00000 + 0.5) - floor(frame.width * 0.00000 + 0.5), floor(frame.height * 1.00000 + 0.5) - floor(frame.height * 0.00000 + 0.5))


        //// Group 2
        //// Background Drawing
        let backgroundPath = UIBezierPath(ovalInRect: CGRectMake(group2.minX + floor(group2.width * 0.00000 + 0.5), group2.minY + floor(group2.height * 0.00000 + 0.5), floor(group2.width * 1.00000 + 0.5) - floor(group2.width * 0.00000 + 0.5), floor(group2.height * 1.00000 + 0.5) - floor(group2.height * 0.00000 + 0.5)))
        backgroundColouring.setFill()
        backgroundPath.fill()


        //// Text Drawing
        let textRect = CGRectMake(group2.minX + floor(group2.width * 0.05500 + 0.5), group2.minY + floor(group2.height * 0.41000 + 0.5), floor(group2.width * 0.93500 + 0.5) - floor(group2.width * 0.05500 + 0.5), floor(group2.height * 0.59500 + 0.5) - floor(group2.height * 0.41000 + 0.5))
        let textStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = .Center

        let textFontAttributes = [NSFontAttributeName: UIFont.boldSystemFontOfSize(UIFont.labelFontSize()), NSForegroundColorAttributeName: UIColor.whiteColor(), NSParagraphStyleAttributeName: textStyle]

        let textTextHeight: CGFloat = NSString(string: textTernary).boundingRectWithSize(CGSizeMake(textRect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: textFontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, textRect);
        NSString(string: textTernary).drawInRect(CGRectMake(textRect.minX, textRect.minY + (textRect.height - textTextHeight) / 2, textRect.width, textTextHeight), withAttributes: textFontAttributes)
        CGContextRestoreGState(context)


        //// Group
        CGContextSaveGState(context)
        CGContextSetAlpha(context, 0.1)
        CGContextBeginTransparencyLayer(context, nil)


        //// Symbol Drawing
        let symbolRect = CGRectMake(group2.minX + floor(group2.width * 0.00000 + 0.5), group2.minY + floor(group2.height * 0.00000 + 0.5), floor(group2.width * 1.00000 + 0.5) - floor(group2.width * 0.00000 + 0.5), floor(group2.height * 1.00000 + 0.5) - floor(group2.height * 0.00000 + 0.5))
        CGContextSaveGState(context)
        UIRectClip(symbolRect)
        CGContextTranslateCTM(context, symbolRect.origin.x, symbolRect.origin.y)
        CGContextScaleCTM(context, symbolRect.size.width / 120, symbolRect.size.height / 120)

        StyleKit.drawProgressRing(rotationAngle: rotationAngle, progress: progress)
        CGContextRestoreGState(context)


        CGContextEndTransparencyLayer(context)
        CGContextRestoreGState(context)
    }

    public class func drawProgressRing(rotationAngle rotationAngle: CGFloat = 2, progress: CGFloat = 0.721) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()

        //// Color Declarations
        let shadow = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)

        //// Variable Declarations
        let clockwiseRotation: CGFloat = 90 + -rotationAngle
        let progressMath: CGFloat = -(360 * progress)

        //// Oval Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, 60, 60)
        CGContextRotateCTM(context, -clockwiseRotation * CGFloat(M_PI) / 180)

        let ovalRect = CGRectMake(-55, -55, 110, 110)
        let ovalPath = UIBezierPath()
        ovalPath.addArcWithCenter(CGPointMake(ovalRect.midX, ovalRect.midY), radius: ovalRect.width / 2, startAngle: 0 * CGFloat(M_PI)/180, endAngle: -progressMath * CGFloat(M_PI)/180, clockwise: true)

        shadow.setStroke()
        ovalPath.lineWidth = 10
        ovalPath.stroke()

        CGContextRestoreGState(context)
    }

}
