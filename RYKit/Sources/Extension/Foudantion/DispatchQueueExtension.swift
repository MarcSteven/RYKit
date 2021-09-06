//
//  DispatchQueueExtension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2020/3/12.
//  Copyright © 2020 Marc Zhao All rights reserved.
//

import Foundation


/// ensure main thread
/// - Parameter work: work closure
public func ensureMainThread(execute work:@escaping @convention(block)() ->Void) {
    if Thread.isMainThread {
        work()
    }else {
        DispatchQueue.main.async {
            work()
        }
    }
}

/// async main
/// - Parameter block: block
public func asyncMain(_ block: (() ->Void)?) {
    DispatchQueue.main.async {
        block!()
    }
}

/// async main delay
/// - Parameters:
///   - duration: duration
///   - block: block
public func asyncMainDelay(duration:TimeInterval = 1,
                           block: (()->Void)?) {
    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
        block!()
    }
}
