//
//  NSTimerExtension.swift
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
// MARK: - Type Aliases

public typealias NSTimerFireBlock = () -> Void

//**********************************************************************************************************************
// MARK: - Internal Class

internal class NSTimerBlockHolder {
    
    let block: NSTimerFireBlock
    
    init(block: NSTimerFireBlock) {
        self.block = block
    }
    
    dynamic func fire() {
        self.block()
    }
}

//**********************************************************************************************************************
// MARK: - Extension

extension NSTimer {
    
    /**
     This class function creates a timer which calls a block once the time interval is complete.
     
     - parameter timeInterval: The number of seconds between firings of the timer. If seconds is less than or equal to 0.0, this method chooses the nonnegative value of 0.1 milliseconds instead.
     - parameter repeats:      If true, the timer will repeatedly reschedule itself until invalidated. If false, the timer will be invalidated after it fires.
     - parameter block:        The block of code that will be called once the number of seconds have finished counting down.
     
     - returns: A new `NSTimer` object, configured according to the specified parameters.
     */
    public class func scheduleTimer(timeInterval: NSTimeInterval, repeats: Bool, block: NSTimerFireBlock) -> NSTimer {
        let blockHolder = NSTimerBlockHolder(block: block)
        return NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: blockHolder, selector: "fire", userInfo: nil, repeats: repeats)
    }
}
