//
//  DataContaining.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2018/12/11.
//  Copyright © 2018 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation
/// 数据包含协议
public protocol DataContaining {
    associatedtype ItemType
    var data:[ItemType] { get }
}

public extension DataContaining {
    var numberOfItems:Int {
        return data.count
    }
    func item(at index:Int) ->ItemType? {
        guard index < numberOfItems else {
            return nil
        }
        return data[index]
    }
}
/// Array遵从DataContaining协议
extension Array:DataContaining {
    public typealias ItemType = Element
    public var data :[ItemType] {
        return self
    }
    
}
/// 可计算的data containing 协议
public protocol MutableDataContaining:DataContaining {
    var data:[ItemType] { get set }
}
public extension MutableDataContaining {
    /// 插入方法
    mutating func insert( _ item:ItemType,at index:Int) {
        data.insert(item, at: index)
    }
}
