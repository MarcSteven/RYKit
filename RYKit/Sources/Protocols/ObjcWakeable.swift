//
//  ObjcWakeable.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/8.
//  Copyright © 2020 Marc Steven All rights reserved.
//

import ObjectiveC

/// 对象可唤醒的协议
 @objc public  protocol ObjcWakeable:NSObjectProtocol {
    static func wakeUp()
}

extension ObjcWakeable {
    static func wakeUp() {
        // Nothing to do here
    }
}
