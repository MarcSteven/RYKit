//
//  OptionalExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/14.
//  Copyright © 2020 Marc Zhao All rights reserved.
//

import Foundation

/// Optional 扩展
public extension Optional where Wrapped ==String {
    /// 是否为空格
    var isBlank:Bool {
        return self?.isBlank ?? true 
    }
}
