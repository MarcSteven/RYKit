//
//  PropertyStoring.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/22.
//  Copyright © 2020 Marc Steven All rights reserved.
//

import Foundation
/** 属性存储协议*/
public protocol PropertyStoring {
    associatedtype T
    
    /// get associatedObject
    /// - Parameters:
    ///   - key: key
    ///   - defaultValue: default value
    func getAssociatedObject(_ key:UnsafeRawPointer!,
                             defaultValue:T) ->T
}


extension PropertyStoring {
    
    /// get associated object
    /// - Parameters:
    ///   - key: key
    ///   - defaultValue: default value
    /// - Returns: return T
    func getAssociatedObject(_ key:UnsafeRawPointer!,
                             defaultValue:T) ->T {
        guard  let value = objc_getAssociatedObject(self, key) as? T else {
            return defaultValue
        }
        return value
    }
}
