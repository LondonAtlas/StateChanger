//
//  SCStateChanger.swift
//  StateChanger
//
//  Copyright © 2016 Tom Marks. All rights reserved.
//
//  The MIT License (MIT)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import UIKit

//**********************************************************************************************************************
// MARK: - Constants

private let SCAnimationSpeed: NSTimeInterval = 0.04
private let SCIndeterminateProgress: CGFloat = 0.618
private let SCMaximumProgress: CGFloat = 1.0
private let SCOriginalRotationAngle: CGFloat = 0.0
private let SCOriginalState: CGFloat = 0.0
private let SCRotationAngleIncrement: CGFloat = 12.0

//**********************************************************************************************************************
// MARK: - Enums

public enum SCStateChangerState: Int {
    case Error, Success, Warning
}

//**********************************************************************************************************************
// MARK: - Class Implementation

@IBDesignable public class SCStateChanger: UIButton {

    //******************************************************************************************************************
    // MARK: - Inspectable
    
    @IBInspectable public var interfaceBuilderState: CGFloat = SCOriginalState {
        didSet { self.theState = SCStateChangerState(rawValue: Int(interfaceBuilderState)) ?? .Success }
    }
    
    @IBInspectable public var progress: CGFloat = SCMaximumProgress {
        didSet { self.setNeedsDisplay() }
    }
    
    @IBInspectable public var rotationAngle: CGFloat = SCOriginalRotationAngle {
        didSet { self.setNeedsDisplay() }
    }
    
    //******************************************************************************************************************
    // MARK: - Public Properties
    
    public var theState: SCStateChangerState = .Success {
        didSet{ self.setNeedsDisplay() }
    }
    
    //******************************************************************************************************************
    // MARK: - Private Properties
    
    private var animationTimer: NSTimer?
    
    //******************************************************************************************************************
    // MARK: - Class Overrides
    
    public override func drawRect(rect: CGRect) {
        
        StyleKit.drawProgressButton(frame: rect, rotationAngle: self.rotationAngle,
            progress: self.progress, state: CGFloat(self.theState.rawValue))
    }
    
    //******************************************************************************************************************
    // MARK: - Public Functions

    /**
    Begins rotating the outer circle.
    */
    func startAnimating() {
        if let _ = self.animationTimer {
            return
        }
        
        self.animationTimer?.invalidate()
        self.animationTimer = nil
        self.progress = SCIndeterminateProgress
        self.animationTimer = NSTimer.scheduleTimer(SCAnimationSpeed, repeats: true) {
            self.rotationAngle += SCRotationAngleIncrement
        }
    }
    
    /**
     Ends and resets the out circles rotation animation.
     */
    func stopAnimating() {
        self.animationTimer?.invalidate()
        self.animationTimer = nil
        self.rotationAngle = SCOriginalRotationAngle
        self.progress = SCMaximumProgress
    }
}
