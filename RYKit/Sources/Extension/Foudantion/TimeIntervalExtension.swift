//
//  TimeIntervalExtension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2020/3/10.
//  Copyright © 2020 Marc Zhao All rights reserved.
//

import Foundation

public extension TimeInterval {
    
    /// day
    /// - Parameter quanlity: quanlity
    /// - Returns: return timeInterval
    static func days(_ quanlity:Double) ->TimeInterval {
        return hours(24) * quanlity
    }
    
    /// day
    /// - Parameter quanlity: quanlity
    /// - Returns: time interval
    static func hours(_ quanlity:Double) ->TimeInterval {
        return minutes(60) * quanlity
    }
    
    /// minute
    /// - Parameter quantity: quantity
    /// - Returns: time interval
    static func minutes(_ quantity:Double) ->TimeInterval {
        return 60 * quantity
    }
}
