//
//  UILayoutPriority+Extension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/1/28.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//


import UIKit

public extension  UILayoutPriority {
    
    /// +
    /// - Parameters:
    ///   - lhs: lhs
    ///   - rhs: rhs
    /// - Returns: UILayoutPriority
    static func +(lhs:UILayoutPriority,rhs:Float) ->UILayoutPriority {
    
        return UILayoutPriority(lhs.rawValue + rhs)
    }
    
    /// -
    /// - Parameters:
    ///   - lhs: lhs
    ///   - rhs: rhs
    /// - Returns: UILayoutPriority
    static func -(lhs:UILayoutPriority,rhs:Float) ->UILayoutPriority {
        return UILayoutPriority(lhs.rawValue - rhs)
    }
}


