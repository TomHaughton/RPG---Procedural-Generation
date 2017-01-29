//
//  Timer.swift
//  testAnimation
//
//  Created by Thomas Haughton on 18/01/2017.
//  Copyright © 2017 Thomas Haughton. All rights reserved.
//

import Foundation

class Timer{
    var startTime: NSDate!
    var endTime: NSDate!
    
    init(duration: NSTimeInterval) {
        startTime = NSDate()
        endTime = startTime.dateByAddingTimeInterval(duration)
    }
    
    func timeLeft() -> NSTimeInterval{
        return max(endTime.timeIntervalSinceNow, 0)
    }
    
    func hasFinished() -> Bool{
        return timeLeft() == 0 ? true : false
    }
}
