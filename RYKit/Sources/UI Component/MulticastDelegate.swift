//
//  MulticastDelegate.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/20.
//  Copyright © 2020 Marc Steven All rights reserved.
//

import Foundation


/// 多转换代理
public class MulticastDelegate<T: NSObject>: NSObject {
    private var delegates: [Weak<T>] = []

    public override init() {
        super.init()
    }
    /// 添加代理
    public func add(_ delegate: T) {
        flatten()
        delegates.append(Weak(delegate))
    }
    /// remove 代理
    public func remove(_ delegate: T) {
        flatten()

        guard let index = delegates.firstIndex(where: { $0 == delegate }) else {
            return
        }

        delegates.remove(at: index)
    }

    /// Removes all elements where the `value` is deallocated.
    private func flatten() {
        for (index, element) in delegates.enumerated() where element.value == nil {
            delegates.remove(at: index)
        }
    }
}
/// MulticastDelegate conform to Sequence
extension MulticastDelegate: Sequence {
    /// 创建迭代器
    public func makeIterator() -> AnyIterator<T> {
        flatten()

        var iterator = delegates.makeIterator()

        return AnyIterator {
            while let next = iterator.next() {
                if let delegate = next.value {
                    return delegate
                }
            }

            return nil
        }
    }
}
