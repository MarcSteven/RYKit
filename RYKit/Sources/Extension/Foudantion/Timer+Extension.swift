//
//  Timer+Extension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/1/23.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation

extension  Timer {
    /// schedule timer
    /// - Parameters:
    ///   - delay: delay
    ///   - handler: handler
    /// - Returns: Timer
    @discardableResult
    
    class func schedule(delay:TimeInterval,handler:@escaping () ->Void) ->Timer! {
        let fireDate = delay + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, 0, 0, 0) { _ in
            handler()
        }
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer!

    }
    
    /// Schedule time
    /// - Parameters:
    ///   - interval: interval
    ///   - handler: handle
    /// - Returns: timer
    @discardableResult
    
    class func schedule(repeatInterval interval:TimeInterval,handler:@escaping ()->Void) ->Timer {
        let fireDate = interval + CFAbsoluteTimeGetCurrent()
               let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, interval, 0, 0) { _ in
                   handler()
               }
               CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
               return timer!
    }
    
    /// Schedule time
    /// - Parameters:
    ///   - interval: interval
    ///   - handler: handler
    /// - Returns: timer
    public class func schedule(repeatInterval interval:TimeInterval,
                               _ handler:@escaping () ->Void) ->Timer {
        let fireDate = interval + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, interval, 0, 0) {_ in
            handler()
        }
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer!
    }
}

extension Timer {
    
    /// Associated key
    private struct AssociatedKey {
        static var timerPauseDate = "timerPauseDate"
        static var timePreviousFireDate = "timerPreviousFireDate"
    }
    
    /// pause date
    private var pauseDate:Date? {
        get {
            objc_getAssociatedObject(self, &AssociatedKey.timerPauseDate) as? Date
            
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.timerPauseDate, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// previous fire date
    private var previousFireDate:Date? {
        get {
            objc_getAssociatedObject(self, &AssociatedKey.timePreviousFireDate) as? Date
            
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.timePreviousFireDate, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// pause
    public func pause() {
        pauseDate = Date()
        previousFireDate = fireDate
        fireDate = Date.distantFuture
    }
    
    /// resume
    public func resume() {
        guard let pauseDate = pauseDate,let previousFireDate = previousFireDate else {
            return
        }
        fireDate = Date(timeInterval: -pauseDate.timeIntervalSinceNow, since: previousFireDate)
    }

}

