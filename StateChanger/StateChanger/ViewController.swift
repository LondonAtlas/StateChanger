//
//  ViewController.swift
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

private let SCIncrementalProgress: CGFloat = 0.01
private let SCMaximumProgress: CGFloat = 1.0
private let SCMinimumProgress: CGFloat = 0.0
private let SCProgressSpeed: NSTimeInterval = 0.04

//**********************************************************************************************************************
// MARK: - Class Implementation

class ViewController: UIViewController {
    
    //******************************************************************************************************************
    // MARK: - Outlets
    
    @IBOutlet var isIndeterminate: UISwitch?
    @IBOutlet var isShowingProgress: UISwitch?
    @IBOutlet var stateButton: SCStateChanger?
    
    //******************************************************************************************************************
    // MARK: - Properties
    
    private var progressAnimationTimer: NSTimer?

    //******************************************************************************************************************
    // MARK: - Actions
    
    @IBAction func buttonTapped(sender: SCStateChanger) {
        
        self.startIndeterminateAnimation()
        self.startProgressIfNecessary()
        
        switch sender.theState {
        case .Error:
            self.stateButton?.theState = .Success
        case .Success:
            self.stateButton?.theState = .Warning
        case .Warning:
            self.stateButton?.theState = .Error
        }
    }
    
    //******************************************************************************************************************
    // MARK: - Private Functions
    
    private func incrementProgress() {
        if self.stateButton?.progress >= SCMaximumProgress {
            self.stateButton?.progress = SCMaximumProgress
            self.resetProgressTimer()
            self.stateButton?.stopAnimating()
        } else {
            self.stateButton?.progress += SCIncrementalProgress
        }
    }
    
    private func resetProgressTimer() {
        self.progressAnimationTimer?.invalidate()
        self.progressAnimationTimer = nil
    }
    
    private func startIndeterminateAnimation() {
        if self.isIndeterminate?.on == true {
            self.stateButton?.startAnimating()
        } else {
            self.stateButton?.stopAnimating()
        }
    }
    
    private func startProgressIfNecessary() {
        if self.isShowingProgress?.on == true {
            self.stateButton?.progress = SCMinimumProgress
            self.resetProgressTimer()
            self.progressAnimationTimer = NSTimer.scheduleTimer(SCProgressSpeed, repeats: true) {
                self.incrementProgress()
            }
        }
    }
}

