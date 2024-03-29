//
//  Copying.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/2/4.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation

/// Define the copy protocol
public protocol Copying {
    init(_ protoType:Self)
}

extension Copying {
    
    /// copy
    /// - Returns: return Self
    public func copy() ->Self {
        return type(of: self).init(self)
    }
}


public extension Array where Element :Copying {
    
    /// deep copy
    /// - Returns: return [Element]
    func deepCopy() ->[Element] {
        return map {$0.copy()}
    }
}
