//
//  TimeInterval+HasPassed.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/13.
//  Copyright © 2020 Marc Steven All rights reserved.
//

import Foundation

extension TimeInterval {
    
    /// hasPassed
    /// - Parameter since: since
    /// - Returns: if has passed, return true, or false 
    public func hasPassed(since:Self) ->Bool {
        return Date().timeIntervalSinceReferenceDate - self > since
    }
}
