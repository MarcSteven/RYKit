//
//  EquatableByPointer.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/21.
//  Copyright © 2020 Marc Steven All rights reserved.
//

import Foundation
/// 通过指针的equaltable协议
public protocol EquatableByPointer:class, Equatable {}

extension EquatableByPointer {
    public static func ==(lhs:Self,rhs:Self) ->Bool {
        let lhs  = Unmanaged<Self>.passUnretained(lhs).toOpaque()
        let rhs = Unmanaged<Self>.passUnretained(rhs).toOpaque()
        return lhs == rhs
    }
}
